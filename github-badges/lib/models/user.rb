def get_languages_from_non_forked_repos(user)
  public_repos = user.repositories.select{|r| r.fork == false}
  merge_language_maps(public_repos.collect{|r| r.languages})
end

def merge_language_maps(maps)
  maps.inject({}) do |total, map|
    map.each do |k, v|
      old_value = total[k] || 0
      total[k] = v + old_value
    end
    total
  end
end
