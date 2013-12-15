# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid "MyString"
    access_token "MyString"
    expire 1
    q1 1
    q2 1
    q3 1
    masters "MyString"
    email "MyString"
    age 1
    birth_date "2013-12-15"
    optin false
  end
end
