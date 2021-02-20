class CreateProjects < ActiveRecord::Migration[6.1]

  def change
    create_table :projects do |t|
      t.belongs_to :user
      t.string :title, null: false
      t.text :description
      t.integer :type, null: false
      t.string :location, null: false
      t.string :thumbnail, null: false
      t.timestamps
    end
  end
end
