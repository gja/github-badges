class Question < ActiveRecord::Base
  is_taggable :tags, :genre
end
