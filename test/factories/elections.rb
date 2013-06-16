FactoryGirl.define do
  factory :election do
    ignore do
      candidacies_count 5
    end

    sequence(:name) {|n| "Election #{n}" }
    sequence(:namespace) {|n| "election#{n}" }
    published true

    after(:create) do |election, evaluator|
      FactoryGirl.create_list(:candidacy, evaluator.candidacies_count, election: election)
    end
  end
end
