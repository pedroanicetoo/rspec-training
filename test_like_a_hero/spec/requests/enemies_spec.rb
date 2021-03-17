require 'rails_helper'

RSpec.describe "Enemies", type: :request do

  describe "GET /enemies" do
    before :each do
      @enemies = FactoryBot.create_list(:enemy, 10) 
      get "/enemies"
    end
    it "works!" do
      expect(response).to have_http_status(200)
    end
    it "should return all enemies" do
      expect(json.map{|x| x.except!("created_at", "updated_at")}).to eq(@enemies.map(&:attributes).map{|x| x.except!("created_at", "updated_at")})
    end
  end

  describe "GET /enemy" do
    context 'when enemy exists' do
      before :each do
        @enemy = FactoryBot.create(:enemy) 
        get "/enemies/#{@enemy.id}"
      end
      it "should return status 200" do
        expect(response.status).to eq(200)
      end
      it "should return enemy" do
        expect(json.except!("created_at", "updated_at")).to eq(@enemy.attributes.except!("created_at", "updated_at"))
      end
    end
    context 'when enemy doesnt exists' do
      before :each do
        get "/enemies/0"
      end
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "POST /enemies" do
    context "when have all enemy_params" do
      let(:enemy_attributes) { 
        {
          name: "inimigo",
          power_base: 1,
          power_step: 1,
          level: 1,
          kind: "goblin" 
        }
       }
       before :each do
        post "/enemies", params: enemy_attributes
       end
       it "returns status code 201" do
        expect(response).to have_http_status(201)
       end
       it "returns a new enemy" do
        expect(json.except!("created_at", "updated_at")).to eq(Enemy.last.attributes.except!("created_at", "updated_at"))
       end
    end

    context "when haven't all enemy_params" do
      let(:enemy_attributes) { {} }
      let(:errors) { 
        {
          "level"=>["is not a number", "can't be blank"], 
          "name"=>["can't be blank"], 
          "power_base"=>["can't be blank"], 
          "power_step"=>["can't be blank"], 
          "kind"=>["can't be blank"]
        }
       }
      before :each do
        post "/enemies", params: enemy_attributes
      end
      it "returns status code 404" do
        expect(response).to have_http_status(422)
      end
      it "returns errors" do
        expect(json["message"]).to eq(errors)
      end
    end
    
  end

  describe "PUT /enemies" do
    context 'when enemy exists' do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { @enemy_attributes = attributes_for(:enemy) }
      before :each do
        put "/enemies/#{enemy.id}", params: enemy_attributes
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "updates the record" do
        expect(enemy.reload).to have_attributes(enemy_attributes)
      end
      it "returns the enemy updated" do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
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
      let(:enemy) { create(:enemy) }
      before :each do
        delete "/enemies/#{enemy.id}"
      end
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
      it "destroy the record" do
        expect{enemy.reload}.to raise_error ActiveRecord::RecordNotFound
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
