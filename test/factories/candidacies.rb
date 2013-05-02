FactoryGirl.define do
  factory :candidacy do
    ignore do
      propositions_count 10
      candidates_count 1
    end

    association :election
    association :organization

    before(:create) do |candidacy, evaluator|
      FactoryGirl.create_list(:proposition, evaluator.propositions_count, candidacy: candidacy)
      FactoryGirl.create_list(:candidate, evaluator.candidates_count, candidacies: [candidacy])
    end
  end
end
