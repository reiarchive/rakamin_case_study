require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  #Create user
  let(:user) { create(:user) }
  
  # initialize test data
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:todo_id) { todos.first.id }

  # authorize request
  let(:headers) { valid_headers }
  
  # Test suite for GET /todos
  describe 'GET /todos' do
    # make HTTP get request before each example
    # Before user auth :
    # before { get '/todos' }
    # After user auth implemented :
    before { get '/todos', params: {}, headers: headers }

    it 'returns todos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /todos/:id' do
    # Before user auth :
    # before { get "/todos/#{todo_id}" }
    # After user auth implemented :
    before { get "/todos/#{todo_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /todos' do
    # valid payload
    # Before user auth :
    # let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }
    # After user auth implemented :
    let(:valid_attributes) { { title: 'Learn Elm', created_by: user.id.to_s }.to_json }

    context 'when the request is valid' do
      # valid payload
      # Before user auth :
      # before { post '/todos', params: valid_attributes }
      # After user auth implemented :
      before { post '/todos', params: valid_attributes, headers: headers }

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      # Before user auth :
      # before { post '/todos', params: { title: 'Foobar' } }
      # After user auth implemented :
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/todos', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /todos/:id' do
    # Before auth
    # let(:valid_attributes) { { title: 'Shopping' } }
    # After auth
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      # Before auth
      # before { put "/todos/#{todo_id}", params: valid_attributes }
      # After auth
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    # Before auth
    # before { delete "/todos/#{todo_id}" }
    # After auth
    before { delete "/todos/#{todo_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end