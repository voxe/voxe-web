FactoryGirl.define do
  factory :proposition do
    sequence(:text) {|n| "Lorem ipsum #{n}" }
    after(:build) do |proposition|
      proposition.tag_names = [FactoryGirl.attributes_for(:tag)[:name]]
    end
    association :candidacy

    factory :proposition_with_tags do
      after(:build) do |p|
        p.tags = FactoryGirl.build_list(:tag, 2)
      end
    end
  end
end
