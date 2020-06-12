class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :logo_url

      t.timestamps
    end
  end
end
