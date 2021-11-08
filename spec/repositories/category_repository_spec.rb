describe CategoryRepository do
  let!(:category_1) { create :category }
  let!(:category_2) { create :category }

  subject { described_class.all }

  it "returns cities" do
    expect(subject).to eq([category_1, category_2])
  end
end
