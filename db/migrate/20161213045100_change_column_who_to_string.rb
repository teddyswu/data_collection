class ChangeColumnWhoToString < ActiveRecord::Migration
  def change
  	change_column :rtmms, :who, :string
  	add_index :rtmms, :who
  	change_column :rtmm_users, :who, :string
  	change_column :rtmm_records, :who, :string
  	change_column :rtmm_histories, :who, :string
  end
end
