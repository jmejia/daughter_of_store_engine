require 'spec_helper'

describe Admin::DashboardController do

  let(:platform_admin) { User.create( { full_name: "Jane Doe",
                                        email: "test@example.com",
                                        password: "password",
                                        platform_administrator: true} )}

  before do
    login_user(platform_admin)
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
