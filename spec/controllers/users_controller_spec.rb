require 'spec_helper'

describe UsersController do

  before :each do
    ignore_security

    @user = mock_model(User, :username => "thiago")
    @parameters = {
      :user => {
        "old_password" => "current password",
        "password" => "new password",
        "password_confirmation" => "new password"
      }
    }
  end

  context "password changing" do
    
    it "should update its own password when current password is right" do
      controller.user = @user

      current_password_is_right
      @user.should_receive(:valid?).and_return(true)
      @user.should_receive(:save!).and_return(true)
      @user.should_receive(:password=).with("new password")
      @user.should_receive(:password_confirmation=).with("new password")

      put :update_password, @parameters

      response.should redirect_to(root_url)
    end

    it "should not update its own password when current password is wrong" do
      controller.user = @user

      current_password_is_wrong
      errors = stub
      errors.should_receive(:add)
      @user.should_receive(:errors).and_return(errors)

      put :update_password, @parameters

      response.should render_template(:edit_password)
    end

    def current_password_is_right
      controller.stub!(:login).and_return(true)
    end

    def current_password_is_wrong
      controller.stub!(:login).and_return(false)
    end
  end

end
