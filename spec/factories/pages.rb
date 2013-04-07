# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    name "MyString"
    slug "MyString"
    content "MyText"
    page_view 1
    status "MyString"
  end
end
