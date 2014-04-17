class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, :uniqueness => true

      t.timestamps
    end
  end
end
