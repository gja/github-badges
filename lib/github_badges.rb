require 'sinatra'
require 'haml'
require 'vendor/octopi/lib/octopi'
require 'less'
require 'active_support/time'

require 'models/badge'
# require 'models/badge/code'
# require 'models/badge/collaboration'
# require 'models/badge/followers'
# require 'models/badge/membership'
# require 'models/badge/misc'
# require 'models/badge/repositories'

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

helpers do
  def badge_link(username)
    "<a href=\"/badges/#{username}\">#{username}</a>"
  end
end

get "/" do
  haml :search, :locals => { :title => "Search" }
end

get '/badges' do
  if params[:username]
    redirect "/badges/#{params[:username]}"
  end
end

get '/badges/:user' do
  begin
    user = ::User.find(params[:user])
    haml :user, :locals => { :title => user.name, :user => user, :badge_categories => Badge.all.group_by(&:category) }
  rescue Octopi::NotFound
    haml :user_not_found, :locals => { :title => params[:user] }
  end
end

get '/application.css' do
  Less.parse File.read("public/application.less")
end

