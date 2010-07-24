class BadgeUser

  def initialize(github_user)
    @github_user = github_user
  end
  
  def self.find(username)
    self.new(Octopi::User.find(username))
  end
  
  def name
    @github_user.name
  end
  
  def badges
    if @github_user.public_repo_count == 1
      [:foo]
    else
      []
    end
  end
  
end