class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :title
      t.string :filename

      t.timestamps
    end
    create_table :likes  do |t|
      t.integer :user_id
      t.integer :picture_id
    end
    create_table :messages  do |t|
      t.string :text
      t.integer :sender_id
      t.integer :receiver_id
    end

    create_table :events do |t|
      t.integer  :eventable_id
      t.string   :eventable_type
      t.integer  :user_id
      t.datetime :created_at
    end
    create_table :urls do |t|
      t.string   :url
    end

    create_table(:admin_users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip


      t.timestamps
    end

    add_index :admin_users, :email,                :unique => true
    add_index :admin_users, :reset_password_token, :unique => true


  create_table :comments do |t|
    t.integer  :user_id
    t.integer  :picture_id
    t.text :body
    t.timestamps
  end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
    create_table :picture_categories do |t|
      t.integer :picture_id
      t.integer :category_id
    end
    create_table :user_categories do |t|
      t.integer :user_id
      t.integer :category_id
    end



    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      ##Facebook
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      #Online?
      t.datetime :last_request_at

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true

  AdminUser.reset_column_information
  AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
  end



  def self.down
    drop_table :admin_notes

  end

end
