FactoryBot.define do
  factory :search do
    name { "MyString" }
    symbol { "MyString" }
    usd_price { "9.99" }
    btc_price { "MyString" }
    percent_change { 1 }
  end
end
