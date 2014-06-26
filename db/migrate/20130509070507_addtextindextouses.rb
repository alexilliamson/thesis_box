class Addtextindextouses < ActiveRecord::Migration
  def change
  	add_index :uses, :text
  end
end
