require 'redcloth-rails/helpers'

module RedCloth
  module Rails

    class Engine < ::Rails::Engine
      initializer "redcloth-rails.action_controller" do |app|
        ActiveSupport.on_load :action_view do
          ActionView::Helpers::FormBuilder.send :include, RedCloth::Rails::Helpers::FormBuilder

          ActionView::Base.send :include, RedCloth::Rails::Helpers::FormHelper
          ActionView::Base.send :include, RedCloth::Rails::Helpers::FormTagHelper
        end
      end
    end

  end
end