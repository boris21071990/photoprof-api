describe Api::V1::CategoriesController do
  describe "GET /api/v1/categories" do
    subject do
      get :index

      response
    end

    let!(:category) { create :category }

    it "returns categories" do
      is_expected.to be_successful

      expect(json).to eq(data: [{ id: category.id, name: category.name }], errors: nil, meta: {})
    end
  end
end
