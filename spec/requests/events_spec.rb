require 'rails_helper'

RSpec.describe "Events CRUD", type: :request do
  let(:admin) { sign_in_as_admin }

  describe "POST /events" do
    let(:valid_params) do
      { event: attributes_for(:event, title: "Board-Game Night") }
    end

    it "creates a new event with valid params" do
      expect {
        post events_path, params: valid_params, session: { user_id: admin.id }
      }.to change(Event, :count).by(1)
    end
  end

  describe "PATCH /events/:id" do
    let(:event) { create(:event) }

    it "updates and redirects" do
      patch event_path(event), params: { event: { location: "Çankaya" } }, session: { user_id: admin.id }
      expect(response).to redirect_to(event_path(event))
    end
  end

  describe "DELETE /events/:id" do
    let!(:event) { create(:event) }

    it "deletes the event" do
      expect {
        delete event_path(event), session: { user_id: admin.id }
      }.to change(Event, :count).by(-1)
    end
  end
end
