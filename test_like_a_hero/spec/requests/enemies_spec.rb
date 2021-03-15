require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "PUT /enemies" do
    context 'when enemy exists' do
      before :each do
        @enemy = create(:enemy)
        @enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{@enemy.id}", params: @enemy_attributes
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "updates the record" do
        expect(@enemy.reload).to have_attributes(@enemy_attributes)
      end
      it "returns the enemy updated" do
        json_response = JSON.parse(response.body)
        expect(@enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at'))
      end
    end

    context 'when enemy does not exist' do
      before :each do
        put '/enemies/0', params: attributes_for(:enemy)
      end
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "DELETE /enemies" do
    context 'when the enemy exists' do
      before :each do
        @enemy = create(:enemy)
        delete "/enemies/#{@enemy.id}"
      end
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
      it "destroy the record" do
        expect{@enemy.reload}.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the enemy does not exists' do
      before :each do
        delete '/enemies/0'
      end
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
    
  end

end
