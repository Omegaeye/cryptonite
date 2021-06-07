require 'rails_helper'

RSpec.describe ShrimpyService, type: :model do
    describe "Testing class method" do
        it "get_data", :vcr do
            response = ShrimpyService.get_data
            expect(response.class).to eq(Array)
        end
    end
end