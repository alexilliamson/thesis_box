class ChangeMonthAndDateTypeInLinks < ActiveRecord::Migration

  def change
  	change_column :links, :day, :text
  	change_column :links, :month, :text
  end

end
