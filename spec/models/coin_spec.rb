require 'rails_helper'

RSpec.describe Coin, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:symbol) }
    it { should validate_presence_of(:usd_price) }
    it { should validate_presence_of(:btc_price) }
    it { should validate_presence_of(:percent_change) }
  end

end
