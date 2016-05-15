FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.free_email }
    password "12345678"
    password_confirmation "12345678"
  end
end

# post :create, user:[email: 'syed@gmail.com', password: '1', password_confirmation: '1'], format: :json

