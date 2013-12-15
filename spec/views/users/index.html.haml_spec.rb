require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
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
      ),
      stub_model(User,
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
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uid".to_s, :count => 2
    assert_select "tr>td", :text => "Access Token".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Masters".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
