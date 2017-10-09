require 'rails_helper'

describe BikesController do
  include Devise::TestHelpers

  before(:each) do
    user = create(:user)
    sign_in user
  end
  
  describe "show action" do
    it "renders show template if a bike is found" do
      bike = create(:bike)
      get :show, id: bike.id
      response.should render_template('show')
    end
  end

  describe "create action" do
    it "redirects to show page if validations pass" do
      post :create, bike: { name: 'bike 1', description: 'description 1', user_id: 1, used_bike: '', category_id: 2 }
      response.should redirect_to(bikes_path)
    end

    it "renders new page again if validations fail" do
      post :create, bike: { name: '', description: 'description 2', user_id: 1, used_bike: '', category_id: 2 }
      response.should render_template('new')
    end
  end

end