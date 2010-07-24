require 'rubygems'
require 'net/http'
require 'json'
require 'ruby-debug'
require 'nokogiri'

def getlocs(obj)
  host = "query.yahooapis.com"

  url = "/v1/public/yql?q=select%20*%20from%20geo.placemaker%20where%20documentContent%20in%20(select%20content%20from%20html%20where%20url%3D\"http://en.wikipedia.org/wiki/" + obj + "\"%20and%20xpath%3D\"//div[%40id%3D'bodyContent']//p\")%20and%20documentType%3D\"text/plain\"%20and%20appid%20%3D%20\"\"&diagnostics=true&env=store://datatables.org/alltableswithkeys&format=json"

  http = Net::HTTP.new(host)
  res = http.get(url)
  f = File.new("/tmp/loc" + obj, "w")
  f.write(res.body)
  f.close
  u2 = "/v1/public/yql?q=select%20*%20from%20html%20where%20url%3D\"http://en.wikipedia.org/wiki/" + obj + "\"%20and%20xpath%3D\"//div[%40id%3D'bodyContent']//p\"&diagnostics=true&env=store://datatables.org/alltableswithkeys"
  res = http.get(u2)
  f = File.new("/tmp/txt" + obj, "w")
  f.write(res.body)
  f.close
end

def getalllocs(obj)
  file = File.new("/tmp/loc" + obj, "r")
  str = ""
  while (data = file.read(4096))
    str << data
  end

  data = JSON.parse str
  r = nil
  texts = {}
  names = {}
  ms = data["query"]["results"]["matches"]
  #badkeys = {}
  ms.each { |m|
    next if !m
    #puts m.inspect
    r = m
    m = m["match"]
    if m.class == Hash
      mt = [m]
    else
      mt = m
    end
    mt.each { |m|
      txt = m["reference"]["text"]
      #badkeys[txt] = 1 if ["Mussolini", "Gandhi", "India"].index(txt)
      #next if ["Mussolini", "Gandhi", "India"].index(txt)
      texts[txt] = [] if !texts[txt]
      name = m["place"]["name"]
      texts[txt] << m
      names[name] = [] if !names[name]
      names[name] << txt
    }
  }
  texts
end

def getallps(obj)
  n = Nokogiri.XML(File.open("/tmp/txt" + obj, "r"))
  y = n.xpath("//p")
  ps = []
  y.each { |q|
    ps << q.content
  }
  ps
end

def selkeys(texts, obj)
  puts texts.keys.inspect
  texts.keys.each { |t|
    puts t
    v = gets
    texts.delete(t) if !v.index("y")
  }
  puts texts.keys.inspect
  f = File.new("/tmp/msloc" + obj, "w")
  f.write(Marshal.dump(texts))
  f.close
  texts
end

def getselkeys(obj)
  file = File.new("/tmp/msloc" + obj, "r")
  str = ""
  while (data = file.read(4096))
    str << data
  end

  Marshal.load(str)
end

obj = "napoleon"
#getlocs(obj)
texts = getalllocs(obj)
ps = getallps(obj)
texts = selkeys(texts, obj)
#texts = getselkeys(obj)
puts texts.keys.inspect

quests = []
bsize = 150
#debugger
texts.each_key { |t|
  puts "LOC: " + t
  ps.each { |p|
    l = p.downcase.index(t.downcase)
    if l
      start = l > bsize ? l - bsize : 0
      fin = (p.size - l - t.size) < bsize ? (p.size - l - t.size) : bsize
      p = p.slice(start, l - start + fin + t.size)
      puts p
      puts "-------------------------------------------------------"
      v = gets
      break if v.index("c")
      next if !v.index("y")
      quests << {:loc => texts[t], :data => p}
    end
  }
}
f = File.new("/tmp/msquest" + obj, "w")
f.write(Marshal.dump(quests))
f.close
