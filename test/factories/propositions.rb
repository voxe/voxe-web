FactoryGirl.define do
  factory :proposition do
    sequence(:text) {|n| "Lorem ipsum #{n}" }
    after(:build) do |proposition|
      proposition.tag_names = [FactoryGirl.attributes_for(:tag)[:name]]
    end
  end
end
