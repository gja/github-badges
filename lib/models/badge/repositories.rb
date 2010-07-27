class Badge
  category "Repositories" do
    badge "It's A Start" do |badge|
      badge.description = "Has exactly one repo"
      badge.target = [ 1 ]
      badge.measure = :public_repo_count
    end

    badge "Toe-Dangler" do |badge|
      badge.description = "Has at least one repo"
      badge.target = 1
      badge.measure = :public_repo_count
    end

    badge "Code Middle Manager" do |badge|
      badge.description = "Has at least ten repos"
      badge.target = 10
      badge.measure = :public_repo_count
    end

    badge "Git Wrangler" do |badge|
      badge.description = "Has at least fifty repos"
      badge.target = 50
      badge.measure = :public_repo_count
    end

    badge "A Rainbow of Gittles" do |badge|
      badge.description = "Has at least a hundred repos"
      badge.target = 100
      badge.measure = :public_repo_count
    end
  end
end

