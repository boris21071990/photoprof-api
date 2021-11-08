describe RegisterUser do
  let(:new_york) { create :city, name: "New York" }

  let(:email) { "test1@gmail.com" }
  let(:password) { "password" }
  let(:first_name) { "John" }
  let(:last_name) { "Doe" }
  let(:city_id) { new_york.id }

  subject do
    described_class.new(email: email,
                        password: password,
                        first_name: first_name,
                        last_name: last_name,
                        city_id: city_id).call
  end

  context "with valid data" do
    it "returns user" do
      expect(subject).to be_success
      expect(subject.data).to include(:user)
    end
  end

  context "with invalid data" do
    context "when the user exists" do
      let!(:user) { create :user, email: email }

      it "returns errors" do
        expect(subject.success?).to eq(false)
        expect(subject.errors).to eq([{ type: "validation", message: "Email is taken" }])
      end
    end

    context "when the first name is empty" do
      let(:first_name) { "" }

      it "returns errors" do
        expect(subject.success?).to eq(false)
        expect(subject.errors).to eq([{ type: "validation", message: "First name can't be blank" }])
      end
    end
  end
end
