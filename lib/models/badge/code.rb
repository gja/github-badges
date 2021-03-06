class Badge
  category "Code" do
    badge "Polyglot" do |badge|
      badge.description = "At least 5 programming languages across all non-forked repos"
      badge.measure = :language_count
      badge.target = 5
    end

    badge "Polygluttonous" do |badge|
      badge.description = "At least 10 programming languages across all non-forked repos"
      badge.measure = :language_count
      badge.target = 10
    end

    badge "Great Expectations" do |badge|
      badge.description = "Has at least one empty repository"
      badge.measure = :empty_repositories_count
      badge.target = 1
    end

    badge "The Great Forker" do |badge|
      badge.description = "Has at least one repository with no commits from the user"
      badge.measure = :repositories_user_has_not_committed_to_count
      badge.target = 1
    end

    badge "A Helping Hand" do |badge|
      badge.description = "A repository started by this user has a commit from someone else"
      badge.target = 1
      badge.measure = :unforked_repositories_which_others_have_comitted_to_count
    end

    badge "The Great Collaborator" do |badge|
      badge.description = "Five repositories started by this user has a commit from someone else"
      badge.target = 5
      badge.measure = :unforked_repositories_which_others_have_comitted_to_count
    end

    badge "Damsel in Distress" do |badge|
      badge.description = "Ten repositories started by this user has a commit from someone else"
      badge.target = 10
      badge.measure = :unforked_repositories_which_others_have_comitted_to_count
    end

    badge "The Butterfly Effect" do |badge|
      badge.description = "At least one unforked repository with a million lines of code"
      badge.target = 1000000

      badge.measure = lambda do |user|
        user.unforked_repositories.map do |repo|
          repo.languages.values.inject(0) { |t,v| t + v }
        end.max || 0
      end
    end
  end
end

