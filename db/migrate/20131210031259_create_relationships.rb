class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :focus_user_id
      t.integer :be_focus_user_id
      t.timestamps
    end
    add_index :relationships ,:focus_user_id
    add_index :relationships ,:be_focus_user_id
  end

end
