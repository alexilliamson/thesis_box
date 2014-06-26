class RemovePhraseIndexFromUses < ActiveRecord::Migration
  def up
  	remove_index :uses, :phrase_id
  end

  def down
  	add_index :uses, :phrase_id
  end
end
