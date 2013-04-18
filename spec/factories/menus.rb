# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :menu do
    name "MyString"
    url "MyString"
    sequence 1
    parent_id 1
    status "MyString"
  end
end
