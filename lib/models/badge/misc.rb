class Badge
  category "Misc" do
    badge "You Get The Gist" do |badge|
      badge.description = "User has created at least one gist"
      badge.measure = :public_gist_count
      badge.target = 1
    end

    badge "A List of Gists" do |badge|
      badge.description = "User has created at least ten gists"
      badge.measure = :public_gist_count
      badge.target = 10
    end

    badge "A Basketful of Gistses" do |badge|
      badge.description = "User has created at least a hundred gists"
      badge.measure = :public_gist_count
      badge.target = 100
    end

    badge "Big in Japan" do |badge|
      badge.description = "You've attained a certain notoriety in the land of the Rising Sun."
      badge.measure = :login
      badge.target = [ "matz", "ko1" ]
    end

    badge "Meta-Git" do |badge|
      badge.description = "User is a maintainer of Git."
      badge.measure = :login
      badge.target = [ "gitster" ]
    end
  end
end

