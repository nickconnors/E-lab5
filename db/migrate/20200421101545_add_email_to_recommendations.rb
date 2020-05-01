class AddEmailToRecommendations < ActiveRecord::Migration[5.2]
  def change
    add_column :recommendations, :email, :string
  end
end
