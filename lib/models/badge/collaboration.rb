class Badge
  category "Collaboration" do
    badge "Great Idea" do |badge|
      badge.description = "At least one of user's repositories has been forked"
      badge.target = 1
      badge.measure = lambda { |user| user.unforked_repositories.select { |repo| repo.forks > 0 }.length}
    end

    badge "The Sands of Tines" do |badge|
      badge.description = "At least ten of user's repositories have been forked"
      badge.target = 10
      badge.measure = lambda { |user| user.unforked_repositories.select { |repo| repo.forks > 0 }.length }
    end

    badge "Pardon Me, Please" do |badge|
      badge.description = "At least one of user's repositories has an open issue"
      badge.target = 1
      badge.measure = lambda { |user| user.repositories.map(&:open_issues).max || 0 }
    end

    badge "It's Broken, Jerk" do |badge|
      badge.description = "At least one of user's repositories has more than a hundred open issues"
      badge.target = 100
      badge.measure = lambda { |user| user.repositories.map(&:open_issues).max || 0 }
    end
  end
end

