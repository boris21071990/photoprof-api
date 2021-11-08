describe PhotosFetcher, search: true do
  let(:category_1) { create :category }
  let(:category_2) { create :category }

  let!(:photo_1) { create :photo, :reindex, category: category_1 }
  let!(:photo_2) { create :photo, :reindex, enabled: false, category: category_1 }
  let!(:photo_3) { create :photo, :reindex, category: category_2 }

  let(:filter) { {} }

  subject { described_class.call(filter) }

  context "when the filter is empty" do
    it "returns photos" do
      expect(subject.to_a).to eq([photo_1, photo_3])
    end
  end

  context "when the filter has category" do
    let(:filter) { { category_id: category_1.id, sort: "-created_at,id", per_page: "10" } }

    it "returns photos" do
      expect(subject.to_a).to eq([photo_1])
    end
  end
end
