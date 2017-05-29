require 'rails_helper'

RSpec.describe TagsController, type: :controller do
    describe "tag#create action" do
        before do
            @note = FactoryGirl.create(:note)
            post :create, params: { tag: { name: 'Crazy' }, note_id: @note.id }
        end

        it "should return 200 status-code" do  
            expect(response).to be_success
        end

        it "should successfully create and save a new tag in our database" do
            expect(@note.tags.first.name).to eq('Crazy')
        end
    end

    describe "tag#create action validations" do
        before do
            note = FactoryGirl.create(:note)
            post :create, params: { tag: { name: ''}, note_id: note.id }
        end

        it "should properly deal with validation errors" do
            expect(response).to have_http_status(:unprocessable_entity)
        end

        it "should return errors json on validations" do
            json = JSON.parse(response.body)
            expect(json['errors']['name'][0]).to eq("can't be blank") 
        end
    end
end
