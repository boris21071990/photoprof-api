describe Api::V1::Photographer::ProfileController do
  describe "GET /api/v1/photographer/profile" do
    subject do
      get :index

      response
    end

    let!(:photographer) { create :photographer }

    before { with_authorization_headers(photographer.user) }

    it "returns photographer profile" do
      is_expected.to be_successful

      expect(json).to eq(data: {
          id: photographer.id,
          city_id: photographer.city_id,
          slug: photographer.slug,
          first_name: photographer.first_name,
          last_name: photographer.last_name,
          description: photographer.description,
          image_url: nil
      }, errors: nil)
    end
  end

  describe "PATCH /api/v1/photographer/profile" do
    subject do
      patch :update, params: { photographer: photographer_params }

      response
    end

    let!(:photographer) { create :photographer, first_name: "William" }
    let(:photographer_params) do
      {
          first_name: "John",
          last_name: photographer.last_name,
          city_id: photographer.city_id,
          description: photographer.description
      }
    end

    before { with_authorization_headers(photographer.user) }

    it "returns photographer profile" do
      is_expected.to be_successful

      expect(json).to eq(data: {
          id: photographer.id,
          city_id: photographer.city_id,
          slug: photographer.slug,
          first_name: "John",
          last_name: photographer.last_name,
          description: photographer.description,
          image_url: nil
      }, errors: nil)
    end
  end

  describe "PATCH /api/v1/photographer/update_image" do
    subject do
      patch :update_image, params: { photographer: photographer_params }

      response
    end

    let!(:photographer) { create :photographer }
    let(:photographer_params) { { image: fixture_file_upload("profile.png", "image/png") } }

    before { with_authorization_headers(photographer.user) }

    it "uploads image" do
      is_expected.to be_successful

      expect(json).to eq(data: {
          image_url: photographer.reload.image(:small).url
      }, errors: nil)
    end
  end
end
