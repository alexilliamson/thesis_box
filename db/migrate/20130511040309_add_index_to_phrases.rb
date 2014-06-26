class AddIndexToPhrases < ActiveRecord::Migration
  def change
  	add_index :phrases, :stem
  end
end
