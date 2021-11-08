describe Api::V1::PhotosController, search: true do
  describe "GET /api/v1/photos" do
    let(:photographer) { create :photographer, first_name: "John", last_name: "Doe", image: fixture_file_upload("profile.png", "image/png") }
    let!(:photo) { create :photo, :reindex, photographer: photographer, image: fixture_file_upload("profile.png", "image/png") }
    let!(:disabled_photo) { create :photo, :reindex, photographer: photographer, enabled: false }

    subject do
      get :index

      response
    end

    it "returns enabled photos" do
      is_expected.to be_successful

      expect(json).to eq(data: [
          {
              id: photo.id,
              category_id: photo.category_id,
              image_url: photo.image.url,
              small_image_url: photo.image(:small).url,
              medium_image_url: photo.image(:medium).url,
              large_image_url: photo.image(:large).url,
              likes_count: photo.likes_count,
              views_count: photo.views_count,
              photographer: {
                  id: photographer.id,
                  city_id: photographer.city_id,
                  slug: photographer.slug,
                  first_name: "John",
                  last_name: "Doe",
                  image_url: photographer.image(:small).url,
                  description: photographer.description
              }
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

  describe "GET /api/v1/photos/:id" do
    let(:photographer) { create :photographer, first_name: "John", last_name: "Doe", image: fixture_file_upload("profile.png", "image/png") }
    let!(:photo) { create :photo, :reindex, photographer: photographer, image: fixture_file_upload("profile.png", "image/png") }

    subject do
      get :show, params: { id: id }

      response
    end

    context "when photo exists" do
      let(:id) { photo.id }

      it "returns photo" do
        is_expected.to be_successful

        expect(json).to eq(data: {
            id: photo.id,
            category_id: photo.category_id,
            image_url: photo.image.url,
            small_image_url: photo.image(:small).url,
            medium_image_url: photo.image(:medium).url,
            large_image_url: photo.image(:large).url,
            likes_count: photo.likes_count,
            views_count: photo.views_count,
            photographer: {
                id: photographer.id,
                city_id: photographer.city_id,
                slug: photographer.slug,
                first_name: "John",
                last_name: "Doe",
                image_url: photographer.image(:small).url,
                description: photographer.description
            }
        }, errors: nil)
      end
    end

    context "when photo doesn't exist" do
      let(:id) { 999999999 }

      it "returns error" do
        expect(subject.status).to eq(404)

        expect(json).to eq(data: nil, errors: [{ type: "not_found", message: "Sorry, not found." }])
      end
    end

    context "when photo is disabled" do
      let!(:disabled_photo) { create :photo, :reindex, photographer: photographer, enabled: false }
      let(:id) { disabled_photo.id }

      it "returns error" do
        expect(subject.status).to eq(404)

        expect(json).to eq(data: nil, errors: [{ type: "not_found", message: "Sorry, not found." }])
      end
    end
  end
end
