# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    sequence(:name) {|n| "France #{n}" }
  end
end
