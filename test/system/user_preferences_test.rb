require "application_system_test_case"

class UserPreferencesTest < ApplicationSystemTestCase
  setup do
    @user_preference = user_preferences(:one)
  end

  test "visiting the index" do
    visit user_preferences_url
    assert_selector "h1", text: "User Preferences"
  end

  test "creating a User preference" do
    visit user_preferences_url
    click_on "New User Preference"

    click_on "Create User preference"

    assert_text "User preference was successfully created"
    click_on "Back"
  end

  test "updating a User preference" do
    visit user_preferences_url
    click_on "Edit", match: :first

    click_on "Update User preference"

    assert_text "User preference was successfully updated"
    click_on "Back"
  end

  test "destroying a User preference" do
    visit user_preferences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User preference was successfully destroyed"
  end
end
