require 'rails_helper'

RSpec.describe 'Brands API', type: :request do
  # initialize test data
  let!(:brands) { create_list(:brand, 10) }
  let(:brand_id) { brands.first.id }

  # Test suite for GET /brands
  describe 'GET /brands' do
    # make HTTP get request before each example
    before { get '/brands' }

    it 'returns brands' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /brands/:id
  describe 'GET /brands/:id' do
    before { get "/brands/#{brand_id}" }

    context 'when the record exists' do
      it 'returns the brand' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(brand_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:brand_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Brand/)
      end
    end
  end

  # Test suite for POST /brands
  describe 'POST /brands' do
    # valid payload
    let(:valid_attributes) { { brand_name: 'BYD', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/brands', params: valid_attributes }

      it 'creates a brand' do
        expect(json['brand_name']).to eq('BYD')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/brands', params: { brand_name: 'Tesla' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /brands/:id
  describe 'PUT /brands/:id' do
    let(:valid_attributes) { { title: 'Pagani' } }

    context 'when the record exists' do
      before { put "/brands/#{brand_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /brands/:id
  describe 'DELETE /brands/:id' do
    before { delete "/brands/#{brand_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end