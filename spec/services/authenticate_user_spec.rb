describe AuthenticateUser do
  let(:user) { create :user }
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  subject { described_class.new("Authorization" => "Bearer #{token}").call }

  context "with valid data" do
    it "returns success data" do
      expect(subject).to be_success
      expect(subject.data).to eq(user: user)
    end
  end

  context "with invalid data" do
    let(:token) { "123" }

    it "returns errors data" do
      expect(subject.success?).to eq(false)
      expect(subject.errors).to eq([{ type: "authorization", message: "Unauthorized user" }])
      expect(subject.data).to be_nil
    end
  end
end
