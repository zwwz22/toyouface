class CreateCollectionRelationships < ActiveRecord::Migration
  def change
    create_table :collection_relationships do |t|
      t.integer :collection_user_id
      t.integer :be_collection_user_id

      t.timestamps
    end
    add_index :collection_relationships ,:collection_user_id
    add_index :collection_relationships ,:be_collection_user_id
  end
end
