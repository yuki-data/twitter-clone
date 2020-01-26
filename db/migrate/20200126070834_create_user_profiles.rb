class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true, unique: true
      t.text :profile
      t.string :thumbnail
      t.string :bg_image

      t.timestamps
    end
  end
end
