describe Api::V1::UserController do
  describe "GET /api/v1/user" do
    subject do
      get :index

      response
    end

    let!(:photographer) { create :photographer, image: fixture_file_upload("profile.png", "image/png") }

    before { with_authorization_headers(photographer.user) }

    it "returns user" do
      is_expected.to be_successful

      expect(json).to eq(data:
        {
          email: photographer.user.email,
          role: "photographer",
          image_url: photographer.image(:small).url
        }, errors: nil)
    end
  end
end
