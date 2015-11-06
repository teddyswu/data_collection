class AddColumnIntoRtmmUser < ActiveRecord::Migration
  def change
  	add_column :rtmm_users, :who, :string, after: :id
  	add_column :rtmm_users, :category, :integer, after: :who
  	add_column :rtmm_users, :is_online, :boolean, after: :category
  end
end
