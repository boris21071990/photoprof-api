describe PhotographersFetcher do
  let(:category_1) { create :category }
  let(:category_2) { create :category }

  let!(:photographer_1) { create :photographer }
  let!(:photographer_2) { create :photographer, enabled: false }
  let!(:photographer_3) { create :photographer }

  let!(:photo_1) { create :photo, photographer: photographer_1, category: category_1 }
  let!(:photo_2) { create :photo, photographer: photographer_2, category: category_1 }
  let!(:photo_3) { create :photo, photographer: photographer_3, category: category_2 }

  let(:filter) { {} }

  subject { described_class.call(1, filter) }

  context "when the filter is empty" do
    it "returns photographers" do
      expect(subject).to eq([photographer_1, photographer_3])
    end
  end

  context "when the filter has category" do
    let(:filter) { { category: category_1.id } }

    it "returns photographers" do
      expect(subject).to eq([photographer_1])
    end
  end
end
