describe PhotographersFetcher, search: true do
  let(:city) { create :city }

  let(:category_1) { create :category }
  let(:category_2) { create :category }

  let!(:photographer_1) { create :photographer, :reindex }
  let!(:photographer_2) { create :photographer, :reindex, enabled: false }
  let!(:photographer_3) { create :photographer, :reindex, city: city }

  let!(:photo_1) { create :photo, :reindex, photographer: photographer_1, category: category_1 }
  let!(:photo_2) { create :photo, :reindex, photographer: photographer_2, category: category_1 }
  let!(:photo_3) { create :photo, :reindex, photographer: photographer_3, category: category_2 }

  let(:filter) { {} }

  subject { described_class.call(filter) }

  context "when the filter is empty" do
    it "returns photographers" do
      expect(subject.to_a).to eq([photographer_1, photographer_3])
    end
  end

  context "when the filter has category_id" do
    let(:filter) { { category_id: category_1.id, sort: "id,-created_at", per_page: "10" } }

    it "returns photographers" do
      expect(subject.to_a).to eq([photographer_1])
    end
  end

  context "when the filter has city_id" do
    let(:filter) { { city_id: city.id } }

    it "returns photographers" do
      expect(subject.to_a).to eq([photographer_3])
    end
  end
end
