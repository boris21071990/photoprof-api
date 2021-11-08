describe CityRepository do
  let!(:city_1) { create :city }
  let!(:city_2) { create :city }

  subject { described_class.all }

  it "returns cities" do
    expect(subject).to eq([city_1, city_2])
  end
end
