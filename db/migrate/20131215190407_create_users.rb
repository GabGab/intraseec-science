class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :access_token
      t.integer :expire
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.string :masters
      t.string :email
      t.integer :age
      t.date :birth_date
      t.boolean :optin, :default => false

      t.timestamps
    end
  end
end
