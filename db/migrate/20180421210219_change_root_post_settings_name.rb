class ChangeRootPostSettingsName < ActiveRecord::Migration[5.1]
  def change
    rename_column :root_posts, :settings, :properties
  end
end
