FactoryGirl.define do
  factory :election do
    sequence(:name) {|n| "Election #{n}" }
    sequence(:namespace) {|n| "election#{n}" }
    published true
    after_build do |election|
      5.times do
        election.candidacies << Factory(:candidacy, election: election)
      end
    end
  end
end
