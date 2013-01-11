FactoryGirl.define do
  factory :election do
    sequence(:name) {|n| "Election #{n}" }
    sequence(:namespace) {|n| "election#{n}" }
    published true
    after(:create) do |election|
      5.times do
        FactoryGirl.create(:candidacy, election: election)
      end
    end
  end
end
