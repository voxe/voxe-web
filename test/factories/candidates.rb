FactoryGirl.define do
  factory :candidate do
    sequence(:firstName) {|n| "John #{n}" }
    sequence(:lastName) {|n| "Doe #{n}" }
  end
end
