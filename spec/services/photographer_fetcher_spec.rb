describe PhotographerFetcher do
  let(:photographer) { create :photographer }
  let(:photographer_id) { photographer.id }

  subject { described_class.call(photographer_id) }

  context "when the photographer exists" do
    it "returns photographer" do
      expect(subject).to eq(photographer)
    end
  end

  context "when the photographer doesn't exist" do
    let(:photographer_id) { 9999999 }

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
