describe Result do
  describe ".success" do
    let(:data) { { type: "success" } }

    subject { described_class.success(data) }

    it "returns success result" do
      expect(subject).to be_success
      expect(subject.data).to eq(type: "success")
    end
  end

  describe ".failure" do
    let(:errors) { { type: "validation", message: "Invalid data" } }

    subject { described_class.failure(errors) }

    it "returns failure result" do
      expect(subject).to be_failure
      expect(subject.errors).to eq([{ type: "validation", message: "Invalid data" }])
    end
  end
end
