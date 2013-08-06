# == Schema Information
#
# Table name: user_categories
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#

require 'spec_helper'

describe UserCategory do

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:user_id).of_type(:integer)}
  it {have_db_column(:category_id).of_type(:integer)}

  it { should allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:category_id) }
  it { should_not allow_mass_assignment_of(:id) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:category_id) }

  it { should belong_to(:user) }
  it { should belong_to(:category) }

end