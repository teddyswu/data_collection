class AddIndexToRtmm < ActiveRecord::Migration
  def change
  	add_index :rtmms, :who
  end
end
