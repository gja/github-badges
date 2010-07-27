class Badge
  category "Followers" do
    badge "Wingman" do |badge|
      badge.description = "Has at least one follower"
      badge.target = 1
      badge.measure = :followers_count
    end

    badge "Rogue Leader" do |badge|
      badge.description = "Has at least ten followers"
      badge.target = 10
      badge.measure = :followers_count
    end

    badge "Cult Leader" do |badge|
      badge.description = "Has at least a hundred followers"
      badge.target = 100
      badge.measure = :followers_count
    end

    badge "Minor Deity" do |badge|
      badge.description = "Has at least a thousand followers"
      badge.target = 1000
      badge.measure = :followers_count
    end

    badge "Center of Attention" do |badge|
      badge.description = "More people follow this user than they follow back"
      badge.measure = :followers_count
      badge.target = lambda { |user| user.followers_count > user.following_count }
    end
  end
end

