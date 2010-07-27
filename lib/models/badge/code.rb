class Badge
  category "Code" do
    badge "Polyglottonous" do |badge|
      badge.description = "At least 5 programming languages across all non-forked repos"
      badge.measure = :language_count
      badge.target = 5
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

