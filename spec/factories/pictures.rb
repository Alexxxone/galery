# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :picture do

    title "BOOBS"
    #sequence(:filename) { |n| File.open(File.join(Rails.root, 'db', 'seed', 'pic_dir','tits', "tits_#{n}.png")) }
    #filename {  }
    filename File.open("#{Rails.root}/db/seed/pic_dir/tits/tits_1.png")
    association :categories ,:factory => :category
  end
end
