require 'sinatra'
require 'haml'
require 'vendor/octopi/lib/octopi'
require 'less'
require 'active_support/time'

require 'models/badge'

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

def badge(name, description, &block)
  Badge.add(:name => name, :description => description, &block)
end

badge "Padawan", "Has at least one repo" do |user|
  user.public_repo_count >= 1
end

badge "Apprentice", "Has at least ten repos" do |user|
  user.public_repo_count >= 10
end

badge "Jedi", "Has at least fifty repos" do |user|
  user.public_repo_count >= 50
end

badge "Dark Lord", "Has at least a hundred repos" do |user|
  user.public_repo_count >= 100
end

badge "Wingman", "Has at least one follower" do |user|
  user.followers_count >= 1
end

badge "Gang Leader", "Has at least ten followers" do |user|
  user.followers_count >= 10
end

badge "Cult Leader", "Has at least a hundred followers" do |user|
  user.followers_count >= 100
end

badge "Minor Deity", "Has at least a thousand followers" do |user|
  user.followers_count >= 1000
end

badge "Fashionably Late", "Has been a member for 6 months" do |user|
  user.created_at < 6.months.ago
end

badge "Chasm Crosser", "Has been a member for a year" do |user|
  user.created_at < 1.year.ago
end

badge "Edge Bleeder", "Has been a member for two years" do |user|
  user.created_at < 2.years.ago
end

badge "Founder", "Taught your grandmother to fork eggs" do |user|
  user.created_at.year < 2008
end

badge "Great Idea", "At least one of user's repositories has been forked" do |user|
  user.repositories.any? {|repo| !repo.fork && repo.forks > 0}
end

badge "Pardon Me, Please", "At least one of user's repositories has an open issue" do |user|
  user.repositories.any? {|repo| repo.open_issues > 0}
end

get "/" do
  "The server is running."
end

get '/badges/:user' do
  user = Octopi::User.find(params[:user])
  haml :user, :locals => { :user => user, :badges => Badge.filter(user) }
end

get '/application.css' do
  Less.parse File.read("public/application.less")
end
