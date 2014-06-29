class ChangeChamberTypeInLinks < ActiveRecord::Migration
  def change
  	change_column :links, :chamber, :text
  end
end
