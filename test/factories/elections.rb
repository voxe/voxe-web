FactoryGirl.define do
  factory :election do
    sequence(:name) {|n| "Election #{n}" }
  end
end
