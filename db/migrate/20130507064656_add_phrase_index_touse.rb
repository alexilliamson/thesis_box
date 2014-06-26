class AddPhraseIndexTouse < ActiveRecord::Migration
  def change
  	add_index :uses, :phrase_id
  	remove_index :phrases, [:stem, :year]
  end
end
