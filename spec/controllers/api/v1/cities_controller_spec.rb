describe Api::V1::CitiesController do
  describe "GET /api/v1/cities" do
    subject do
      get :index

      response
    end

    let!(:city) { create :city }

    it "returns cities" do
      is_expected.to be_successful

      expect(json).to eq(data: [{ id: city.id, name: city.name }], errors: nil, meta: {})
    end
  end
end
