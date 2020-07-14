describe ViewsUpdater do
  let(:photo) { create :photo }
  let(:ip) { Faker::Internet.ip_v4_address }
  let(:view_date) { Date.today }

  subject { described_class.new(photo, ip, view_date).call }

  context "when the photo is not viewed" do
    it "updates views for the photo" do
      expect { subject }.to change { photo.views_count }.by(1)
    end

    it "returns success data" do
      expect(subject).to be_success
      expect(subject.data).to eq(viewed: false)
    end
  end

  context "when photo is already viewed" do
    let(:view_hash) { Digest::MD5.hexdigest([photo.class.to_s, photo.id, ip, view_date].join("")) }
    let!(:view) { create :view, viewable: photo, view_hash: view_hash }

    it "doesn't update views for the photo" do
      expect { subject }.to_not change { photo.views_count }
    end

    it "returns success data" do
      expect(subject).to be_success
      expect(subject.data).to eq(viewed: true)
    end
  end
end
