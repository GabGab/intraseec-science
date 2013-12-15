require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :uid => "MyString",
      :access_token => "MyString",
      :expire => 1,
      :q1 => 1,
      :q2 => 1,
      :q3 => 1,
      :masters => "MyString",
      :email => "MyString",
      :age => 1,
      :optin => false
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_uid[name=?]", "user[uid]"
      assert_select "input#user_access_token[name=?]", "user[access_token]"
      assert_select "input#user_expire[name=?]", "user[expire]"
      assert_select "input#user_q1[name=?]", "user[q1]"
      assert_select "input#user_q2[name=?]", "user[q2]"
      assert_select "input#user_q3[name=?]", "user[q3]"
      assert_select "input#user_masters[name=?]", "user[masters]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_age[name=?]", "user[age]"
      assert_select "input#user_optin[name=?]", "user[optin]"
    end
  end
end
