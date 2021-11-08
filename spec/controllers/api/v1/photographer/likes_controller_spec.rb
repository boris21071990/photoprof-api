describe Api::V1::Photographer::LikesController do
  describe "POST /api/v1/likes/:id" do
    let!(:first_photographer) { create :photographer }
    let!(:second_photographer) { create :photographer }

    let!(:second_photographer_photo) { create :photo, photographer: second_photographer }

    before { with_authorization_headers(first_photographer.user) }

    context "create" do
      subject do
        post :create, params: { id: second_photographer_photo.id }

        response
      end

      it "likes the photo" do
        expect { subject }.to change { second_photographer_photo.likes.reload.size }.by(1)
      end
    end

    context "destroy" do
      subject do
        post :destroy, params: { id: second_photographer_photo.id }

        response
      end

      let!(:like) { create :like, photographer: first_photographer, photo: second_photographer_photo }

      it "unlikes the photo" do
        expect { subject }.to change { second_photographer_photo.likes.reload.size }.by(-1)
      end
    end
  end
end
