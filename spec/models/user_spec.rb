# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  last_request_at        :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:email).of_type(:string)}
  it {have_db_column(:uid).of_type(:string)}
  it {have_db_column(:name).of_type(:string)}
  it {have_db_column(:oauth_token).of_type(:string)}
  it {have_db_column(:oauth_expires_at).of_type(:datetime)}
  it {have_db_column(:provider).of_type(:string)}
  it {have_db_column(:encrypted_password).of_type(:string)}
  it {have_db_column(:reset_password_token).of_type(:string)}
  it {have_db_column(:reset_password_sent_at).of_type(:datetime)}
  it {have_db_column(:last_request_at).of_type(:datetime)}
  it {have_db_column(:remember_created_at).of_type(:datetime)}
  it {have_db_column(:sign_in_count).of_type(:integer)}
  it {have_db_column(:current_sign_in_at).of_type(:datetime)}
  it {have_db_column(:last_sign_in_at).of_type(:datetime)}
  it {have_db_column(:current_sign_in_ip).of_type(:string)}
  it {have_db_column(:last_sign_in_ip).of_type(:string)}
  it {have_db_column(:created_at).
      of_type(:datetime).
      with_options(:null => false)}
  it {have_db_column(:updated_at).
      of_type(:datetime).
      with_options(:null => false)}

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) }

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:uid) }
  it { should allow_mass_assignment_of(:provider) }
  it { should allow_mass_assignment_of(:name) }

  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

  it { should have_many(:comments).dependent(:destroy)}
  it { should have_many(:likes).dependent(:destroy)}
  it { should have_many :user_categories }
  it { should have_many(:categories).through(:user_categories) }
  it { should have_many(:events) }
  it { should have_many(:senders).class_name("Message").with_foreign_key(:sender_id) }
  it { should have_many(:receivers).class_name("Message").with_foreign_key(:receiver_id) }
  it { should accept_nested_attributes_for(:events)}

  context "create users" do
    before :each do
      5.times do
        user = FactoryGirl.create(:user)
      end
    end
    it "should be right quantity of user" do
      User.count.should == 5
    end
  end
 end
