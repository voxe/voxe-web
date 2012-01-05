FactoryGirl.define do
  factory :candidate do
    sequence(:first_name) {|n| "John #{n}" }
    sequence(:last_name) {|n| "Doe #{n}" }
    sequence(:namespace) {|n| "johndoe#{n}" }
  end
end
