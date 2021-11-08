describe LoginUser do
  let(:email) { "test1@gmail.com" }
  let(:password) { "password" }

  subject { described_class.new(email: email, password: password).call }

  context "with valid data" do
    let!(:user) { create :user, email: "test1@gmail.com", password: "password" }

    it "returns user" do
      expect(subject).to be_success
      expect(subject.data).to include(:user)
    end
  end

  context "with invalid data" do
    let!(:user) { create :user, email: "test1@gmail.com", password: "password" }

    context "when the email has invalid format" do
      let(:email) { "test123" }

      it "returns errors" do
        expect(subject.success?).to eq(false)
        expect(subject.errors).to eq([{ type: "validation", message: "Email is invalid" }])
      end
    end

    context "when the password is empty" do
      let(:password) { "" }

      it "returns errors" do
        expect(subject.success?).to eq(false)
        expect(subject.errors).to eq([{ type: "validation", message: "Password can't be blank" }])
      end
    end

    context "when the password is invalid" do
      let(:password) { "123" }

      it "returns errors" do
        expect(subject.success?).to eq(false)
        expect(subject.errors).to eq([{ type: "validation", message: "Password is not valid" }])
      end
    end
  end

  context "when the user doesn't exist" do
    it "returns errors" do
      expect(subject.success?).to eq(false)
      expect(subject.errors).to eq([{ type: "validation", message: "User not found" }])
    end
  end
end
