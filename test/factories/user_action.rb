FactoryGirl.define do
  factory :user_action do
    association :user
    association :proposition

    factory :favorite_user_action, class: UserAction::Favorite
    factory :against_user_action, class: UserAction::Favorite
    factory :support_user_action, class: UserAction::Favorite
  end
end
