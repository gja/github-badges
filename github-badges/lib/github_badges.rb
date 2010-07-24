require 'sinatra'
require 'haml'
require 'sass'
require 'octopi'
require 'models/badge'

# Number of repositories > 1, 10, 50
# Number of forks 1, 10, 50
# Number of repositories forked 1, 10, 50
# Made first commit
# Repo owner merged a commit you made (honored a pull request)
# More than 10 commits in a day
# At least 1 commit a day for a week, month (dedicated maintainer)
# At least one commit on a shared gravatar, as per Hashrocket (matt+obie@hashrocket.com)
# Contributed to a "popular" project (e.g. Rails)
# Maintainer of a "popular" project
# New member badge, 6 months, 2 years
# Github founder badge
# Meta-git badge for user who is a maintainer of git

set :haml, :format => :html5

def badge(name, &block)
  Badge.add(name, &block)
end

badge "Has at least one repo" do |user|
  user.public_repo_count >= 1
end

badge "Has at least ten repos" do |user|
  user.public_repo_count >= 10
end

get "/" do
  "The server is running."
end

get '/users/:user' do
  user = Octopi::User.find(params[:user])
  haml :user, :locals => { :user => user, :badges => Badge.filter(user) }
end
