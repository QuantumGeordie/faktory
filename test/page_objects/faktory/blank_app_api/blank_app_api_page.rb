module PageObjects
  module Faktory
    module BlankAppApi
      class BlankAppApiPage < FaktoryPage
        path :welcome_blank_app

        element :results, :locator => '#js-blank_app_results'
      end
    end
  end
end
