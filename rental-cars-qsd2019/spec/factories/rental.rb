FactoryBot.define do
  factory :rental do
    code {'XFB0000'}
    start_date {Date.today}
    end_date {7.days.from_now}
    client {create(:client)}
    car_category {create(:car_category)}
    user {create(:user)}
  end
end
