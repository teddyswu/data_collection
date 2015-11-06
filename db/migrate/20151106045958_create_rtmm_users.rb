class CreateRtmmUsers < ActiveRecord::Migration
  def change
    create_table :rtmm_users do |t|

      t.timestamps null: false
    end
  end
end
