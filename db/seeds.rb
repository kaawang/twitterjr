require 'faker'



bob = User.create(:user_name => 'bob', :password =>'hello')

5.times do
  User.create(
    user_name: Faker::Name.name,
    password: Faker::Internet.user_name
    )
end

(1..5).to_a.each do |user_id|
  5.times do
    Tweet.create(
      content: Faker::Lorem.sentence,
      user_id: user_id
    )
  end
end
