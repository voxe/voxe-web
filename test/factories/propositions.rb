FactoryGirl.define do
  factory :proposition do
    sequence(:text) {|n| "Lorem ipsum #{n}" }
    after_build do |proposition|
      proposition.tags << Factory(:tag)
    end
  end
end
