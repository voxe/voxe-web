FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "benjamin+#{n}@joinplato.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :admin, :class => User do
    sequence(:email) {|n| "benjamin+admin#{n}@joinplato.com" }
    password 'password'
    password_confirmation 'password'
    admin true
  end
end
