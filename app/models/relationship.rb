class Relationship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :focus_user ,:class_name => 'User'
  belongs_to :be_focus_user, :class_name => 'User'
end
