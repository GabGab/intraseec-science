require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :uid => "Uid",
      :access_token => "Access Token",
      :expire => 1,
      :q1 => 2,
      :q2 => 3,
      :q3 => 4,
      :masters => "Masters",
      :email => "Email",
      :age => 5,
      :optin => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uid/)
    rendered.should match(/Access Token/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Masters/)
    rendered.should match(/Email/)
    rendered.should match(/5/)
    rendered.should match(/false/)
  end
end
