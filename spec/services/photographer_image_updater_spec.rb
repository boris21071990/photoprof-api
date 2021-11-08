describe PhotographerImageUpdater do
  let!(:photographer) { create :photographer }

  subject do
    described_class.new(photographer, fixture_file_upload("profile.png", "image/png")).call
  end

  context "with valid data" do
    it "returns image url" do
      expect(subject).to be_success
      expect(subject.data).to include(:image_url)
    end
  end
end
