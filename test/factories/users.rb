FactoryGirl.define do
  factory :user do
    name 'Gentle user'
    sequence(:email) {|n| "benjamin+#{n}@joinplato.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :admin, :class => User do
    name 'Admin killer'
    sequence(:email) {|n| "benjamin+admin#{n}@joinplato.com" }
    password 'password'
    password_confirmation 'password'
    admin true
  end
end
