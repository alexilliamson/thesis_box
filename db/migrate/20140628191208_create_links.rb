class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :url
      t.integer :day
      t.integer :month
      t.integer :year
      t.text :title
      t.integer :chamber

      t.timestamps
    end
  end
end
