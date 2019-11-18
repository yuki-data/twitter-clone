class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :fan, foreign_key: { to_table: :users }
      t.timestamps
      t.index [:user_id, :fan_id], unique: true
    end
  end
end
