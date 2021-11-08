describe PhotographerRepository do
  describe ".find_enabled_by_slug!" do
    let(:photographer) { create :photographer }
    let(:slug) { photographer.slug }

    subject { described_class.find_enabled_by_slug!(slug) }

    context "when the photographer exists" do
      it "returns photographer" do
        expect(subject).to eq(photographer)
      end
    end

    context "when the photographer doesn't exist" do
      let(:slug) { "test" }

      it "raises an exception" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the photographer is not enabled" do
      let(:photographer) { create :photographer, enabled: false }

      it "raises an exception" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
