class AddSpeakerIndexToPassages < ActiveRecord::Migration
  def change
  	add_index :passages, :speaker_id
  	remove_index :uses, :passage_id
  	remove_index :uses, :phrase_id
  	remove_index :uses, :text
  end
end
