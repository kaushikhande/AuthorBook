class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    # Trackable
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
    # t.string :first_name
    # t.string :last_name
    # t.integer  :sign_in_count, default: 0, null: false
    # t.datetime :current_sign_in_at
    # t.datetime :last_sign_in_at
    # t.string   :current_sign_in_ip
    # t.string   :last_sign_in_ip

    # Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    # t.string   :confirmation_token
    # t.datetime :confirmed_at
    # t.datetime :confirmation_sent_at
    # t.string   :unconfirmed_email # Only if using reconfirmable

    # Lockable
    add_column :users, :failed_attempts, :integer, default: 0, null: false
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
    # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
    # t.string   :unlock_token # Only if unlock strategy is :email or :both
    # t.datetime :locked_at

    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
