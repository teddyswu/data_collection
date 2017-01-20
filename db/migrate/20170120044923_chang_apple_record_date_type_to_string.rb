class ChangAppleRecordDateTypeToString < ActiveRecord::Migration
  def change
  	change_column :rtmm_apple_records, :date, :string
  end
end
