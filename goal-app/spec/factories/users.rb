FactoryBot.define do
  factory :user do
    username { Faker::JapaneseMedia::OnePiece.character }
    password { 'password' }
    # session_token { Faker::Code.nric }
  end
end
