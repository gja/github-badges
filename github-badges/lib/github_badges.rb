require 'sinatra'
require 'haml'
require 'vendor/octopi/lib/octopi'
require 'less'
require 'active_support/time'

require 'models/badge'
require 'models/user'

# -- Number of repositories > 1, 10, 50
# -- Number of forks 1, 10, 50
# Number of repositories forked 1, 10, 50
# Made first commit
# Repo owner merged a commit you made (honored a pull request)
# More than 10 commits in a day
# At least 1 commit a day for a week, month (dedicated maintainer)
# At least one commit on a shared gravatar, as per Hashrocket (matt+obie@hashrocket.com)
# Contributed to a "popular" project (e.g. Rails)
# Maintainer of a "popular" project
# -- New member badge, 6 months, 2 years
# -- Github founder badge
# Meta-git badge for user who is a maintainer of git
# badge "Cowboy", "At least one repo without any tests or specs"
# badge "Reliable Forker", "Public repos contains only forks"
# badge "Hard Forker", "Public repos at least 10 forks"

set :haml, :format => :html5

def badge(name, &block)
  Badge.add(:name => name).tap do |badge|
    block.call badge
  end
end

badge "It's A Start" do |badge|
  badge.category = "Repositories"
  badge.description = "Has exactly one repo"
  badge.target = [ 1 ]
  badge.measure = :public_repo_count
end

badge "Toe-Dangler" do |badge|
  badge.category = "Repositories"
  badge.description = "Has at least one repo"
  badge.target = 1
  badge.measure = :public_repo_count
end

badge "Code Middle Manager" do |badge|
  badge.category = "Repositories"
  badge.description = "Has at least ten repos"
  badge.target = 10
  badge.measure = :public_repo_count
end

badge "Git Wrangler" do |badge|
  badge.category = "Repositories"
  badge.description = "Has at least fifty repos"
  badge.target = 50
  badge.measure = :public_repo_count
end

badge "A Rainbow of Gittles" do |badge|
  badge.category = "Repositories"
  badge.description = "Has at least a hundred repos"
  badge.target = 100
  badge.measure = :public_repo_count
end

badge "Wingman" do |badge|
  badge.category = "Followers"
  badge.description = "Has at least one follower"
  badge.target = 1
  badge.measure = :followers_count
end

badge "Rogue Leader" do |badge|
  badge.category = "Followers"
  badge.description = "Has at least ten followers"
  badge.target = 10
  badge.measure = :followers_count
end

badge "Cult Leader" do |badge|
  badge.category = "Followers"
  badge.description = "Has at least a hundred followers"
  badge.target = 100
  badge.measure = :followers_count
end

badge "Minor Deity" do |badge|
  badge.category = "Followers"
  badge.description = "Has at least a thousand followers"
  badge.target = 1000
  badge.measure = :followers_count
end

badge "Late to the Party" do |badge|
  badge.category = "Membership"
  badge.description = "Has been a member for 6 months"
  badge.target = lambda { |user| user.created_at < 6.months.ago }
  badge.measure = :created_at
end

badge "Early Chasm Crosser" do |badge|
  badge.category = "Membership"
  badge.description = "Has been a member for a year"
  badge.target = lambda { |user| user.created_at < 1.year.ago }
  badge.measure = :created_at
end

badge "Edge Bleeder" do |badge|
  badge.category = "Membership"
  badge.description = "Has been a member for two years"
  badge.target = lambda { |user| user.created_at < 2.years.ago }
  badge.measure = :created_at
end

badge "Taught Grandma To Fork Eggs" do |badge|
  badge.category = "Membership"
  badge.description = "User is a founder of Github"
  badge.target = [ "mojombo", "defunkt", "pjhyett" ]
  badge.measure = :login
end

badge "Great Idea" do |badge|
  badge.category = "Collaboration"
  badge.description = "At least one of user's repositories has been forked"
  badge.target = 1
  badge.measure = lambda { |user| user.repositories.reject(&:fork).select{|repo| repo.forks > 0}.length}
end

badge "The Sands of Tines" do |badge|
  badge.category = "Collaboration"
  badge.description = "At least ten of user's repositories have been forked"
  badge.target = 10
  badge.measure = lambda { |user| user.repositories.reject(&:fork).select{|repo| repo.forks > 0}.length}
end

badge "Pardon Me, Please" do |badge|
  badge.category = "Collaboration"
  badge.description = "At least one of user's repositories has an open issue"
  badge.target = 1
  badge.measure = lambda { |user| user.repositories.map{|repo| repo.open_issues}.max}
end

badge "It's Broken, Jerk" do |badge|
  badge.category = "Collaboration"
  badge.description = "At least one of user's repositories has more than a hundred open issues"
  badge.target = 100
  badge.measure = lambda { |user| user.repositories.map{|repo| repo.open_issues}.max}
end

badge "Center of Attention" do |badge|
  badge.category = "Followers"
  badge.description = "More people follow this user than they follow back"
  badge.measure = :followers_count
  badge.target = lambda { |user| user.followers_count > user.following_count }
end

badge "You Get The Gist" do |badge|
  badge.category = "Misc"
  badge.description = "User has created at least one gist"
  badge.measure = :public_gist_count
  badge.target = 1
end

badge "A List of Gists" do |badge|
  badge.category = "Misc"
  badge.description = "User has created at least ten gists"
  badge.measure = :public_gist_count
  badge.target = 10
end

badge "A Basketful of Gistses" do |badge|
  badge.category = "Misc"
  badge.description = "User has created at least a hundred gists"
  badge.measure = :public_gist_count
  badge.target = 100
end

badge "Big in Japan" do |badge|
  badge.category = "Misc"
  badge.description = "You've attained a certain notoriety in the land of the Rising Sun."
  badge.measure = :login
  badge.target = [ "matz", "ko1" ]
end

badge "Polygluttonous" do |badge|
  badge.category = "Code"
  badge.description = "At least 5 programming languages across all non-forked repos"
  badge.measure = lambda {|user| get_languages_from_non_forked_repos(user).length }
  badge.target = 5
end

badge "The Butterfly Effect" do |badge|
  badge.category = "Code"
  badge.description = "At least one unforked repository with a million lines of code"
  badge.measure = lambda {|user| user.repositories.map{|repo| repo.languages.values.inject(0){|t,v| t + v}}.max}
  badge.target = 1000000
end

get "/" do
  "The server is running."
end

get '/badges/:user' do
  user = Octopi::User.find(params[:user])
  haml :user, :locals => { :user => user, :badges => Badge.all }
end

get '/application.css' do
  Less.parse File.read("public/application.less")
end
