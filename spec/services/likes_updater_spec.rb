describe LikesUpdater do
  let!(:photographer_1) { create :photographer }
  let!(:photo_1) { create :photo, photographer: photographer_1 }

  let!(:photographer_2) { create :photographer }
  let!(:photo_2) { create :photo, photographer: photographer_2 }

  describe "#like" do
    subject { described_class.new(photographer_1, photo_2).like }

    it "updates likes_count" do
      expect { subject }.to change { photo_2.likes_count }.by(1)
    end

    it "returns success data" do
      expect(subject).to be_success
      expect(subject.data).to eq(is_liked: true, likes_count: 1)
    end
  end

  describe "#unlike" do
    let!(:like) { create :like, photographer: photographer_1, photo: photo_2 }

    subject { described_class.new(photographer_1, photo_2).unlike }

    it "updates likes_count" do
      expect { subject }.to change { photo_2.likes_count }.by(-1)
    end

    it "returns success data" do
      expect(subject).to be_success
      expect(subject.data).to eq(is_liked: false, likes_count: 0)
    end
  end
end
