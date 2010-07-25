def get_languages_from_non_forked_repos(user)
  merge_language_maps user.repositories.reject(&:fork).collect(&:languages)
end

def merge_language_maps(maps)
  maps.inject(Hash.new(0)) do |total, map|
    map.each do |language, line_count|
      total[language] += line_count
    end
    total
  end
end
