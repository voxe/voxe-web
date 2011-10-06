FactoryGirl.define do
  factory :theme do
    sequence(:name) {|n| "Theme #{n}" }
  end
end
