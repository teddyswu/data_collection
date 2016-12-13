class ChangeColumnWhoToText < ActiveRecord::Migration
  def change
  	remove_index :rtmms, :who
  	change_column :rtmms, :who, :text
  	change_column :rtmm_users, :who, :text
  	change_column :rtmm_records, :who, :text
  	change_column :rtmm_histories, :who, :text
  end
end
