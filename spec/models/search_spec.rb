require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of(:name)}
    it { should validate_uniqueness_of(:symbol)}
  end
end
