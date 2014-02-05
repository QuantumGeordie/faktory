module PageObjects
  module Faktory
    class Navigation < ::AePageObjects::Element

      def home!
        node.find('nav li.name a').click
        PageObjects::Faktory::HomePage.new
      end

      def users!
        node.find_link('users').click
        PageObjects::Faktory::Users::UsersPage.new
      end

      def lines!
        node.find_link('lines').click
        PageObjects::Faktory::Lines::LinesPage.new
      end

      def rework!
        node.find_link('lines').click
        PageObjects::Faktory::Rework::ReworkPage.new
      end


    end
  end
end


