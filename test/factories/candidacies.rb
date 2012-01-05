FactoryGirl.define do
  factory :candidacy do
    after_create do |candidacy|
      Factory(:organization, candidacies: [candidacy])
      10.times do
        Factory(:proposition, candidacy: candidacy)
      end
      Factory(:candidate, candidacies: [candidacy])
    end
  end
end
