require 'rails_helper'

RSpec.describe 'Cars API' do
  # Initialize the test data
  let!(:brand) { create(:brand) }
  let!(:cars) { create_list(:car, 20, brand: brand) }
  let(:brand_id) { brand.id }
  let(:id) { cars.first.id }

  # Test suite for GET /brands/:brand_id/cars
  describe 'GET /brands/:brand_id/cars' do
    before { get "/brands/#{brand_id}/cars" }

    context 'when brand exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all brand cars' do
        expect(json.size).to eq(20)
      end
    end

    context 'when brand does not exist' do
      let(:brand_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find brand/i)
      end
    end
  end

  # Test suite for GET /brands/:brand_id/cars/:id
  describe 'GET /brands/:brand_id/cars/:id' do
    before { get "/brands/#{brand_id}/cars/#{id}" }

    context 'when brand item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when brand item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Car/)
      end
    end
  end

  # Test suite for PUT /brands/:brand_id/cars
  describe 'POST /brands/:brand_id/cars' do
    let(:valid_attributes) { { name: 'CRV', car_type: 'SUV', is_used: false, release_year: 2022 } }

    context 'when request attributes are valid' do
      before { post "/brands/#{brand_id}/cars", params: { car: valid_attributes } }

      it 'returns status code 201' do
        # puts response.body
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/brands/#{brand_id}/cars", params: { car: {} } }

      it 'returns status code 422' do
        # puts response.body
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /brands/:brand_id/cars/:id
  describe 'PUT /brands/:brand_id/cars/:id' do
    let(:valid_attributes) { { name: 'Jazz' } }

    before { put "/brands/#{brand_id}/cars/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the car' do
        updated_car = Car.find(id)
        expect(updated_car.name).to match(/Jazz/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Car/)
      end
    end
  end

  # Test suite for DELETE /brands/:id
  describe 'DELETE /brands/:id' do
    before { delete "/brands/#{brand_id}/cars/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end