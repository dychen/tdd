require 'spec_helper'

describe "Shows" do
  it "should be able to add new shows" do
    visit "/"

    page.should have_content("Shows List")

    click_link("New Show")

    page.should have_content("New Show")

    fill_in "Name", :with => "Family Guy"
    fill_in "Picture", :with => "http://somephoto.com"

    click_button "Submit"

    page.should have_content "Shows List"
    page.should have_content "Family Guy"
    page.should have_content "http://somephoto.com"
    page.should have_link "Edit"
  end

  describe "index" do
    let(:show) { FactoryGirl.create(:show) }
    before do
      visit shows_path(show)
    end
    it "should be able to go to update page" do
      click_link "Edit"
      current_path.should == edit_show_path(show)
    end
  end

  describe "edit" do
    let(:show) { FactoryGirl.create(:show) }
    let(:new_name) { "Simpsons" }
    let(:new_picture) { "http://someotherphoto.com" }
    before do
      visit edit_show_path(show)
    end
    it "should have desired content" do
      page.should have_content "Update"
      page.should have_button "Update"
      page.should have_link "Cancel"
    end
    it "should update the current user" do
      fill_in "Name", :with => new_name
      fill_in "Picture", :with => new_picture
      click_button "Update"
      current_path.should == "/"
      show.reload.name.should == new_name
      show.reload.picture.should == new_picture
    end
    it "should cancel updating the current user" do
      original_name = show.name
      original_picture = show.picture
      click_link "Cancel"
      current_path.should == "/"
      show.reload.name.should == original_name
      show.reload.picture.should == original_picture
    end
  end

end
