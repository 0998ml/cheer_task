class CreateGroupUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :group_users do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
