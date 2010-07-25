require 'rubygems'
require 'sqlite3'

if ARGV.size != 2
  p "ruby <script> <db_file_path> <marshalled_dump_file_path>"
  exit 0
end

db = SQLite3::Database.new(ARGV[0])

data = ''
file = File.open(ARGV[1],'r')

file.each_line do |line|
  data += line
end

questions = Marshal.load(data)

questions.each do |question|
  text = question[:data]
  answer = question[:loc][0]["reference"]["text"]
  latitude = question[:loc][0]["place"]["centroid"]["latitude"]
  longitude = question[:loc][0]["place"]["centroid"]["longitude"]
  something = text.gsub('"','').gsub("\n"," ").gsub("'","\\'")
  db.execute("insert into questions (text,answer,latitude,longitude,created_at,updated_at) values ('#{something}',?,?,?,datetime('now'),datetime('now'))", answer, latitude, longitude)
end

