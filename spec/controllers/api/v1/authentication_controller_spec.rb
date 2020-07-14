describe Api::V1::AuthenticationController do
  describe "POST /api/v1/authentication/login" do
    subject do
      post :login, params: params

      response
    end

    context "with valid params" do
      let!(:user) { create :user, email: params[:email], password: params[:password] }

      let(:params) { { email: "test@example.com", password: "123" } }

      it "logins an user" do
        is_expected.to be_successful

        expect(json).to include(data: include(:token), errors: nil)
      end
    end

    context "with invalid params" do
      let!(:user) { create :user, email: "test123@example.com", password: "123" }

      context "when the email is invalid" do
        let(:params) { { email: "test", password: "123" } }

        it "returns an errors" do
          expect(subject.status).to eq(422)

          expect(json).to eq(data: nil, errors: [{ type: "validation", message: "Email is invalid" }])
        end
      end

      context "when the user doesn't exist" do
        let(:params) { { email: "test234@example.com", password: "123" } }

        it "returns an errors" do
          expect(subject.status).to eq(422)

          expect(json).to eq(data: nil, errors: [{ type: "validation", message: "User not found" }])
        end
      end

      context "when the password is invalid" do
        let(:params) { { email: "test123@example.com", password: "4567" } }

        it "returns an errors" do
          expect(subject.status).to eq(422)

          expect(json).to eq(data: nil, errors: [{ type: "validation", message: "Password is not valid" }])
        end
      end
    end
  end

  describe "POST /api/v1/authentication/register" do
    let(:city) { create :city }

    subject do
      post :register, params: params

      response
    end

    context "with valid params" do
      let(:params) do
        {
          email: "test@example.com",
          password: "123",
          first_name: "Test first name",
          last_name: "Test second name",
          city_id: city.id
        }
      end

      it "creates a photographer" do
        is_expected.to be_successful

        expect(json).to include(data: include(:token), errors: nil)
      end

      context "when the user exists" do
        let(:params) do
          {
            email: "test@example.com",
            password: "123",
            first_name: "Test first name",
            last_name: "Test second name",
            city_id: city.id
          }
        end

        let!(:existing_user) { create :user, email: params[:email], password: params[:password] }

        it "returns an errors" do
          is_expected.to have_http_status(422)

          expect(json).to eq(data: nil, errors: [{ type: "validation", message: "Email is taken" }])
        end
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          email: "test",
          password: "123",
          first_name: "Test first name",
          last_name: "Test second name",
          city_id: city.id
        }
      end

      it "returns an errors" do
        is_expected.to have_http_status(422)

        expect(json).to eq(data: nil, errors: [{ type: "validation", message: "Email is invalid" }])
      end
    end
  end
end
