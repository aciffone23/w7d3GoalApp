class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.bigint :user_id, null: false 
      t.timestamps
    end

    add_foreign_key :goals, :users, column: :user_id
  end
end
