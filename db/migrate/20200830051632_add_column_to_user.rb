class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :fullname, :string
    add_column :users, :website,  :string
    add_column :users, :phone_number, :string
    add_column :users, :self_introduction, :string, limit: 500
    add_column :users, :sex, :integer, null: false, default: 0
  end
end
