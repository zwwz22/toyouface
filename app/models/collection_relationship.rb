class CollectionRelationship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :collection_user ,:class_name => 'User'
  belongs_to :be_collection_user ,:class_name => 'User'
end
