require 'rails_helper'

RSpec.describe 'Items API' do
  # Create user
  let(:user) { create(:user) }

  # Create todos and user items
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }

  # Take todo and items id for test
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  
  # Set valid header
  let(:headers) { valid_headers }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/items' do
    # Before auth
    # before { get "/todos/#{todo_id}/items" }
    # After auth
    before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
    # Before auth
    # before { get "/todos/#{todo_id}/items/#{id}" }
    # After auth
    before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items
  describe 'POST /todos/:todo_id/items' do
    # Before auth
    # let(:valid_attributes) { { name: 'Visit Narnia', done: false } }
    # After auth
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      # Before auth
      # before { post "/todos/#{todo_id}/items", params: valid_attributes }
      # After auth
      before do
        post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      # Before auth
      # before { post "/todos/#{todo_id}/items", params: {} }
      # After auth  
      before { post "/todos/#{todo_id}/items", params: {}, headers: headers }
      
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /todos/:todo_id/items/:id' do
    # Before
    # let(:valid_attributes) { { name: 'Mozart' } }
    # before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes }
    # After auth
    let(:valid_attributes) { { name: 'Mozart' }.to_json }
    
    before do
      put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers
    end

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    # Before auth
    # before { delete "/todos/#{todo_id}/items/#{id}" }
    # After auth
    before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }
    
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end