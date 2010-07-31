class User

  def self.find(*args)
    self.new(Octopi::User.find(*args))
  end

  def initialize(user)
    @octopi_user = user
  end

  # Hate. But you can't subclass Octopi::User. At all.
  def method_missing(method_name, *args, &block)
    @octopi_user.send(method_name, *args, &block)
  end

  def languages
    merge_language_maps self.unforked_repositories.collect(&:languages)
  end

  def language_count
    languages.length
  end

  def unforked_repositories
    repositories.reject(&:fork)
  end

  def empty_repositories
    repositories.select{|r| r.commits.empty? }
  end

  def empty_repositories_count
    empty_repositories.length
  end

  def repositories_user_has_not_committed_to
    repositories.reject{|r| r.commits.any? {|c| c.author["login"] == self.login}}
  end

  def repositories_user_has_not_committed_to_count
    repositories_user_has_not_committed_to.count
  end

  def unforked_repositories_which_others_have_comitted_to
    unforked_repositories.reject { |r| r.commits.all? {|c| c.author["login"] == self.login } }
  end

  def unforked_repositories_which_others_have_comitted_to_count
    unforked_repositories_which_others_have_comitted_to.count
  end

  private

    def merge_language_maps(maps)
      maps.inject(Hash.new(0)) do |total, map|
        map.each do |language, line_count|
          total[language] += line_count
        end
        total
      end
    end
end
