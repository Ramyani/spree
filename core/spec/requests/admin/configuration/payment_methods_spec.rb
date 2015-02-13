require 'spec_helper'

describe "Payment Methods" do
  stub_authorization!

  before(:each) do
    visit spree.admin_path
    click_link "Configuration"
  end

  context "admin editing a payment method" do
    before(:each) do
      2.times { create(:payment_method) }
      click_link "Payment Methods"
      within(:css, 'table#listing_payment_methods tbody:nth-child(2) tr:nth-child(1)') { click_link "Edit" }
    end

    it "should be able to edit an existing payment method" do
      fill_in "payment_method_name", :with => "Payment 99"
      click_button "Update"
      page.should have_content("successfully updated!")
      find_field("payment_method_name").value.should == "Payment 99"
    end

    it "should display validation errors" do
      fill_in "payment_method_name", :with => ""
      click_button "Update"
      #page.should have_content("Name can't be blank")
    end
  end
end
