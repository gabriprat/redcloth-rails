module RedCloth
  module Rails
    module Helpers

      module FormBuilder
        # @see RedCloth::Rails::Helpers::FormHelper#textile_editor
        def textile_editor(method, options = {})
          @template.textile_editor(@object_name, method, options.merge(:object => @object))
        end
      end

    end
  end
end