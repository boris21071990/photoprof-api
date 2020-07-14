describe PhotosFetcher do
  let(:category_1) { create :category }
  let(:category_2) { create :category }

  let!(:photo_1) { create :photo, category: category_1 }
  let!(:photo_2) { create :photo, enabled: false, category: category_1 }
  let!(:photo_3) { create :photo, category: category_2 }

  let(:filter) { {} }

  subject { described_class.call(1, filter) }

  context "when the filter is empty" do
    it "returns photos" do
      expect(subject).to eq([photo_1, photo_3])
    end
  end

  context "when the filter has category" do
    let(:filter) { { category: category_1.id } }

    it "returns photos" do
      expect(subject).to eq([photo_1])
    end
  end
end
