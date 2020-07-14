describe PhotographerUpdater do
  let(:new_york) { create :city, name: "New York" }

  let(:first_name) { "John" }
  let(:last_name) { "Doe" }
  let(:city_id) { new_york.id }

  let!(:photographer) { create :photographer, first_name: "William" }

  subject do
    described_class.new(photographer, { first_name: first_name, last_name: last_name, city_id: city_id }).call
  end

  context "with valid data" do
    it "returns photographer" do
      expect { subject }.to change { photographer.first_name }.from("William").to(first_name)
      expect(subject).to be_success
      expect(subject.data).to include(:photographer)
    end
  end

  context "with invalid data" do
    context "when the first name is empty" do
      let(:first_name) { "" }

      it "returns errors" do
        expect(subject.success?).to eq(false)
        expect(subject.errors).to eq([{ type: "validation", message: "First name can't be blank" }])
      end
    end
  end
end
