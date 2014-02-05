module PageObjects
  module Faktory
    class FaktoryPage < ::AePageObjects::Document
      element :navigation, :is => Navigation, :locator => "nav"
    end
  end
end
