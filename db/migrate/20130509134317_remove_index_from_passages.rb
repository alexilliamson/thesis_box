class RemoveIndexFromPassages < ActiveRecord::Migration
  def change
  	remove_index :passages, :speaker_id
  end
end
