FactoryGirl.define do
  factory :tag do
    sequence(:name) {|n| "Tag #{n}" }
    sequence(:namespace) {|n| "tag-#{n}" }
  end
end
