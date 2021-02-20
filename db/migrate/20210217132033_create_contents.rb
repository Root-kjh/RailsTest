class CreateContents < ActiveRecord::Migration[6.1]

  def change
    create_table :contents do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
