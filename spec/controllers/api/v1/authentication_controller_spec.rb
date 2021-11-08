describe Api::V1::AuthenticationController do
  describe "POST /api/v1/authentication/login" do
    subject do
      post :login, params: { login: params }

      response
    end

    context "with valid params" do
      let!(:user) { create :user, email: params[:email], password: params[:password] }

      let(:params) { { email: "test@example.com", password: "123" } }

      it "logins an user" do
        is_expected.to be_successful

        expect(json).to include(data: include(:token), errors: nil)
        expect(cookies["jwt_refresh"]).to be_present
        expect(cookies["XSRF-TOKEN"]).to be_present
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
      post :register, params: { registration: params }

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
        expect(cookies["jwt_refresh"]).to be_present
        expect(cookies["XSRF-TOKEN"]).to be_present
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

  describe "POST /api/v1/authentication/refresh" do
    let!(:user) { create :user }

    subject do
      post :refresh

      response
    end

    context "with valid refresh and CSRF tokens" do
      before { with_refresh_token(user) }

      it "returns new access and CSRF tokens" do
        is_expected.to be_successful

        expect(json).to include(data: include(:token), errors: nil)
        expect(cookies["XSRF-TOKEN"]).to be_present
      end
    end

    context "without refresh and CSRF tokens" do
      it "returns error" do
        subject

        expect(json).to eq(data: nil, errors: [{ type: "authorization", message: "Unauthorized user" }])
      end
    end

    context "with expired refresh token" do
      let(:expiration_time) { JWTSessions.refresh_exp_time + 60 }

      before { with_refresh_token(user) }

      it "returns error" do
        Timecop.travel(expiration_time.seconds.from_now) do
          subject

          expect(json).to eq(data: nil, errors: [{ type: "authorization", message: "Unauthorized user" }])
        end
      end
    end
  end
end
