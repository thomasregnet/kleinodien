require "test_helper"

class Identity::EmailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:kim))
  end

  test "should get edit" do
    get edit_identity_email_url

    assert_response :success
  end

  test "should update email" do
    patch identity_email_url, params: {email: "new_email@hey.com", current_password: "123TopSecret"}

    assert_redirected_to root_url
  end

  test "should not update email with wrong current password" do
    patch identity_email_url, params: {email: "new_email@hey.com", current_password: "456WrongSecret"}

    assert_redirected_to edit_identity_email_url
    assert_equal "The password you entered is incorrect", flash[:alert]
  end
end
