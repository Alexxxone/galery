# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    sequence(:title) { |n| "cat_#{n}.jpg"  }
    filename { File.open(File.join(Rails.root, "/db/seed/pic_dir/cats/cat_#{rand(10) + 1}.jpg"))  }
  end
  factory :another_picture,:parent => :picture do
    sequence(:title) { |n| "chr_#{n}.jpg"  }
    filename { File.open(File.join(Rails.root, "/db/seed/pic_dir/christmas/chr_#{rand(10) + 1}.jpg"))  }
  end
end
