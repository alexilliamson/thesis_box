class RemoveColumnFromPhrases < ActiveRecord::Migration
  def up
    remove_column :phrases, :year
    add_column :phrases, :chi2b, :float
  end

  def down
    add_column :phrases, :year, :integer
    remove_column :phrases, :chi2b
  end
end
