require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do
    before :each do
      @weapons = create_list(:weapon, 3)
    end
    it "works! (now write some real specs)" do
      get weapons_path
      expect(response).to have_http_status(200)
    end
    context "check if weapon attributes is present" do
      it "the weapon's name is present" do
        get weapons_path
        @weapons.each do |weapon|
          expect(response.body).to include(weapon.name)
        end
      end
      it "the weapon's current_power is present" do
        get weapons_path
        @weapons.each do |weapon|
          expect(response.body).to include(weapon.current_power.to_s)
        end
      end
      it "the weapon's title is present" do
        get weapons_path
        @weapons.each do |weapon|
          expect(response.body).to include(weapon.title)
        end
      end
      it "the weapon link id present" do
        get weapons_path
        @weapons.each do |weapon|
          href = '/weapons/'+weapon.id.to_s
          expect(response.body).to include(href)
        end
      end
    end
  end

  describe "GET /weapon" do
    context "Should return weapon attributes" do
      weapon = FactoryBot.create(:weapon)
      it "the weapon name is present" do
        get weapons_path(weapon.id)
        expect(response.body).to include(weapon.name)
      end

      it "the weapon current_power is present" do
        get weapons_path(weapon.id)
        expect(response.body).to include(weapon.current_power.to_s)
      end

      it "the weapon title is present" do
        get weapons_path(weapon.id)
        expect(response.body).to include(weapon.title)
      end
    end
  end

  describe "POST /weapons" do
    weapon_attributes = FactoryBot.attributes_for(:weapon)
    context "when it has valid parameters" do 
      it "create the weapon with correct attributes" do
        post weapons_path, params:{weapon: weapon_attributes}
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
      it "should redirect_to weapons_path" do
        post weapons_path, params: {weapon: weapon_attributes}
        expect(response).to redirect_to weapons_path
      end
    end

    context "when it has no valid parameters" do 
      it "does not create weapon" do
        expect{ 
          post weapons_path, params:{weapon: {name: ''}}
        }.to_not change(Weapon, :count)
      end
    end

  end

  describe "DELETE /weapon" do
    context "Should delete selected weapon" do
      weapons = FactoryBot.create_list(:weapon, 2)
      it "should delete selected weapon" do
        expect { 
          delete "/weapons/#{weapons.last.id}"
         }.to change { Weapon.count }.by(-1)
      end
    end
  end

end