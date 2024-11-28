class RenameOverviewToMovies < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :overwiew, :overview
  end
end
