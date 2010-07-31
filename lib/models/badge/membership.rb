class Badge
  category "Membership" do
    badge "Noob Chutney" do |badge|
      badge.description = "Has been a member for less than 6 months"
      badge.target = lambda { |user| user.created_at > 6.months.ago }
      badge.measure = :created_at
    end

    badge "Please To Pull My Fork" do |badge|
      badge.description = "Has been a member for at least six months"
      badge.target = lambda { |user| user.created_at <= 6.months.ago }
      badge.measure = :created_at
    end

    badge "Apt Gitter" do |badge|
      badge.description = "Has been a member for a year"
      badge.target = lambda { |user| user.created_at < 1.year.ago }
      badge.measure = :created_at
    end

    badge "All Your Rebase" do |badge|
      badge.description = "Has been a member for two years"
      badge.target = lambda { |user| user.created_at < 2.years.ago }
      badge.measure = :created_at
    end

    badge "Taught Grandma To Fork Eggs" do |badge|
      badge.description = "User is a founder of Github"
      badge.target = [ "mojombo", "defunkt", "pjhyett" ]
      badge.measure = :login
    end

    badge "Shameless Plug" do |badge|
      badge.description = "User helped with the github-badges app"
      badge.target = [ "bguthrie", "gja", "mneedham" ]
      badge.measure = :login
    end
  end
end

