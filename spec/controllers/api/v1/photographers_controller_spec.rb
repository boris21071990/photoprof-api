describe Api::V1::PhotographersController do
  describe "GET /api/v1/photographers" do
    let!(:photographer) { create :photographer, first_name: "John", last_name: "Doe" }

    subject do
      get :index

      response
    end

    it "returns photographers" do
      is_expected.to be_successful

      expect(json).to eq(data: [
        {
          id: photographer.id,
          categories: [],
          city_id: photographer.city_id,
          city: {
            id: photographer.city.id,
            name: photographer.city.name
          },
          description: photographer.description,
          first_name: "John",
          last_name: "Doe",
          image_url: nil,
          photos: []
        }
      ], errors: nil, meta: {
        pagination: {
          per_page: 20,
          total_pages: 1,
          total_records: 1
        }
      })
    end
  end

  describe "GET /api/v1/photographers/:id" do
    let!(:photographer) { create :photographer, first_name: "John", last_name: "Doe", image: fixture_file_upload("profile.png", "image/png") }

    subject do
      get :show, params: { id: id }

      response
    end

    context "when photographer exists" do
      let(:id) { photographer.id }

      it "returns photographer" do
        is_expected.to be_successful

        expect(json).to eq(data: {
          id: photographer.id,
          categories: [],
          city_id: photographer.city_id,
          city: {
            id: photographer.city.id,
            name: photographer.city.name
          },
          description: photographer.description,
          first_name: "John",
          last_name: "Doe",
          image_url: photographer.image(:small).url,
          photos: []
        }, errors: nil)
      end
    end

    context "when photographer doesn't exist" do
      let(:id) { 999999999 }

      it "returns error" do
        expect(subject.status).to eq(404)

        expect(json).to eq(data: nil, errors: [{ type: "not_found", message: "Sorry, not found." }])
      end
    end

    context "when photographer is disabled" do
      let!(:disabled_photographer) { create :photographer, enabled: false }
      let(:id) { disabled_photographer.id }

      it "returns error" do
        expect(subject.status).to eq(404)

        expect(json).to eq(data: nil, errors: [{ type: "not_found", message: "Sorry, not found." }])
      end
    end
  end
end
