require 'spec_helper'

describe PictureCategory do

    it {have_db_column(:picture_id).of_type(:integer)}
    it {have_db_column(:category_id).of_type(:integer)}
    it {have_db_column(:created_at).
        of_type(:datetime).
        with_options(:null => false)}
    it {have_db_column(:updated_at).
        of_type(:datetime).
        with_options(:null => false)}

    it { should allow_mass_assignment_of(:picture_id) }
    it { should allow_mass_assignment_of(:category_id) }
    it { should_not allow_mass_assignment_of(:id) }
    it { should_not allow_mass_assignment_of(:created_at) }
    it { should_not allow_mass_assignment_of(:updated_at) }

    it { should validate_presence_of(:picture_id) }
    it { should validate_presence_of(:category_id) }

    it { should belong_to(:picture) }
    it { should belong_to(:category) }

end