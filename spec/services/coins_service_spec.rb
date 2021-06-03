require 'rails_helper'

RSpec.describe CoinsService, type: :model do
    describe "Testing class method" do
        it "get_data", :vcr do
            response = CoinsService.get_data
            expect(response.class).to eq(Array)
        end
    end
end