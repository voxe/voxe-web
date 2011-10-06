FactoryGirl.define do
  factory :proposition do
    sequence(:text) {|n| "Lorem ipsum #{n}" }
  end
end
