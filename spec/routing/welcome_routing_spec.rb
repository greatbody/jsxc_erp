require "rails_helper"

RSpec.describe WelcomeController, type: :routing do
  describe "routing" do
    it 'routes to #index' do
      expect(:get => '/').to route_to('welcome#index')
    end

    it "routes to #demo" do
      expect(:get => "/welcome/demo").to route_to("welcome#demo")
    end
  end
end
