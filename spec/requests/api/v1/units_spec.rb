# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Units' do
  let(:unit) { create(:one_bedroom_unit) }

  describe 'GET /unit' do
    context 'when showing a unit' do
      let(:unit_url) { "/api/v1/units/#{unit.id}" }

      context 'with valid listing ID' do
        before { get unit_url }

        it 'returns a successful response' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns the requested unit' do
          expect(unit).to be_valid
          json_response = response.parsed_body
          expect(json_response).to have_key('unit')
        end
      end
    end
  end
end
