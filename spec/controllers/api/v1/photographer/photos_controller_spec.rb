describe Api::V1::Photographer::PhotosController do
  describe "GET /api/v1/photographer/photos" do
    subject do
      get :index

      response
    end

    let!(:photographer) { create :photographer }
    let!(:photo) { create :photo, image: fixture_file_upload("profile.png", "image/png"), photographer: photographer }

    before { with_authorization_headers(photographer.user) }

    it "returns photographer photos" do
      is_expected.to be_successful

      expect(json).to eq(data: [
          {
              id: photo.id,
              category_id: photo.category.id,
              image_url: photo.image.url,
              small_image_url: photo.image(:small).url,
              medium_image_url: photo.image(:medium).url,
              large_image_url: photo.image(:large).url,
              likes_count: photo.likes_count,
              views_count: photo.views_count
          }
      ], errors: nil, meta: {})
    end
  end

  describe "POST /api/v1/photographer/photos" do
    subject do
      post :create, params: { photo: { image: image } }

      response
    end

    let!(:photographer) { create :photographer }
    let(:image) { fixture_file_upload("profile.png", "image/png") }

    before { with_authorization_headers(photographer.user) }

    it "uploads photo" do
      is_expected.to be_successful

      expect(json).to include(:data)
    end
  end
end
