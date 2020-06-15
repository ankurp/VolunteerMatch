class CreateLikeableModel < ActiveRecord::Migration[6.0]
  def change
    create_table :likes, force: true do |t|
      t.references :user, null: false
      t.references :likable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
