describe PhotoCreator do
  let(:photographer) { create :photographer }

  subject { described_class.new(photographer, photo_params).call }

  let(:photo_params) { { image: fixture_file_upload("profile.png", "image/png") } }

  it "creates a photo" do
    expect(subject).to be_success
    expect(subject.data).to include(:photo)
  end
end
