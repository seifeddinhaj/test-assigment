require 'rails_helper'

RSpec.describe 'RewardsController', type: :request do
  describe "#POST" do
    it 'returns errors when data is invalid' do
      post "/rewards"
      expect(response.status).to eq 422
      expect(response.body).to eq "{\"errors\":{\"data\":[\"can't be blank\"]}}"
    end

    it 'returns result for valid data' do
      str = <<-REWARD
        2018-06-12 09:41 A recommends B
        2018-06-14 09:41 B accepts
        2018-06-16 09:41 B recommends C
      REWARD

      post '/rewards', params: str, headers: {}

      expect(response.status).to eq 200
      expect(response.body).to eq "{\"A\":1.0}"
    end
  end
end
