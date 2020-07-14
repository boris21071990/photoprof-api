describe JsonWebToken do
  let(:payload) { { user_id: 1 }.with_indifferent_access }

  let(:jwt_token) { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDYyOTU0MDB9.KRHBv1l2pumG7sUi6jd_oayeoeMHr6Ohd83xrjD2oyU" }

  before { Timecop.freeze(Time.local(2019)) }
  after { Timecop.return }

  describe ".encode" do
    subject { described_class.encode(payload) }

    it "encodes the payload" do
      expect(subject).to eq(jwt_token)
    end
  end

  describe ".decode" do
    subject { described_class.decode(jwt_token) }

    context "when the token is valid" do
      it "returns the payload" do
        expect(subject).to eq(payload)
      end
    end

    context "when the token is expired" do
      it "raises an exception" do
        Timecop.freeze(29.minutes.from_now)

        expect(described_class.decode(jwt_token)).to eq(payload)

        Timecop.freeze(2.minutes.from_now)

        expect { described_class.decode(jwt_token) }.to raise_error(JWT::ExpiredSignature)
      end
    end
  end
end
