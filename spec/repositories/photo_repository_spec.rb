describe PhotoRepository do
  describe ".find_enabled_by_id!" do
    let(:photo) { create :photo }
    let(:photo_id) { photo.id }

    subject { described_class.find_enabled_by_id!(photo_id) }

    context "when the photo exists" do
      it "returns photo" do
        expect(subject).to eq(photo)
      end
    end

    context "when the photo doesn't exist" do
      let(:photo_id) { 9999999 }

      it "raises an exception" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the photo is not enabled" do
      let(:photo) { create :photo, enabled: false }

      it "raises an exception" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
