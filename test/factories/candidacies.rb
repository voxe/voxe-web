FactoryGirl.define do
  factory :candidacy do
    after(:create) do |candidacy|
      organization = FactoryGirl.build(:organization)
      organization.candidacies = [candidacy]
      organization.save!
      10.times do
        proposition = FactoryGirl.build(:proposition)
        proposition.candidacy = candidacy
        proposition.save!
      end
      candidate = FactoryGirl.build(:candidate)
      candidate.candidacies = [candidacy]
      candidate.save!
    end
  end
end
