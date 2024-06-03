class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :year_of_experience, :years_of_experience
  end
end
