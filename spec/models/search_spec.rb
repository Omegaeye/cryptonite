require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:symbol)}
  end
end
