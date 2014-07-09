module RedCloth
  module Rails
    module Helpers

      module FormHelper
        # Returns a textarea opening and closing tag set tailored for accessing a specified attribute (identified by +method+)
        # on an object assigned to the template (identified by +object+). Additional options on the input tag can be passed as a
        # hash with +options+ and places the textile toolbar above it
        #
        # @param [Symbol]   object_name   name of the model
        # @param [Symbol]   method_name   name of the models attribute
        # @param [Hash]     options       HTML options to customize the textarea element
        #
        #   Samples:
        #   textile_editor(:post, :body, :cols => 20, :rows => 40)
        #   # => <textarea cols="20" rows="40" id="post_body" name="post[body]">
        #   # #{@post.body}
        #   # </textarea>
        #
        #   textile_editor(:comment, :text, :size => "20x30")
        #   # => <textarea cols="20" rows="30" id="comment_text" name="comment[text]">
        #   # #{@comment.text}
        #   # </textarea>
        #
        #   textile_editor(:application, :notes, :cols => 40, :rows => 15, :class => 'app_input')
        #   # => <textarea cols="40" rows="15" id="application_notes" name="application[notes]" class="app_input">
        #   # #{@application.notes}
        #   # </textarea>
        #
        #   textile_editor(:entry, :body, :size => "20x20", :disabled => 'disabled')
        #   # => <textarea cols="20" rows="20" id="entry_body" name="entry[body]" disabled="disabled">
        #   # #{@entry.body}
        #   # </textarea>
        #
        def textile_editor(object_name, method, options = {})
          editor_id = options[:id] || '%s_%s' % [object_name, method]
          mode      = options.delete(:simple) ? 'simple' : 'extended'
          (@textile_editor_ids ||= []) << [editor_id.to_s, mode.to_s]

          if ActionPack::VERSION::MAJOR > 3
            ActionView::Helpers::Tags::TextArea.new(object_name, method, self, options).render
          else
            ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).to_text_area_tag(options)
          end
        end

        # Registers a further button on the TextileEditor toolbar.
        # Must be called before the TextileEditor gets initialized.
        #
        # @param [String] text      text to display (contents of button tag, so HTML is valid as well)
        # @param [Hash]   options   options Hash as supported by +content_tag+ helper in Rails
        #
        #   Example:
        #   Add a button labeled 'Greeting' which triggers an alert dialog.
        #
        #   <% textile_editor_button 'Greeting', :onclick => "alert('Hello!')" %>
        #
        def textile_editor_button(text, options={})
          return textile_editor_button_separator if text == :separator
          button = content_tag(:button, text, options)
          button = "TextileEditor.addButton(\"%s\");" % escape_javascript(button)
          (@textile_editor_buttons ||= []) << button
          return nil
        end

        # Registers a separator on the TextileEditor toolbar.
        # Must be called before the TextileEditor gets initialized.
        #
        # @param [Hash] options
        #
        def textile_editor_button_separator(options={})
          button = "TextileEditor.addButton(new TextileEditorButtonSeparator('%s'));" % (options[:simple] || '')
          (@textile_editor_buttons ||= []) << button
          return nil
        end

        # Initialize the TextileEditor. after the DOM was loaded.
        #
        # @param [Array]  dom_ids
        # @param [Hash]   options
        #
        #   Sample with jQuery DOM ready event:
        #   <script type="text/javascript">
        #     jQuery(document).ready(function() {
        #       TextileEditor.initialize('article_body', 'extended');
        #       TextileEditor.initialize('article_body_excerpt', 'simple');
        #     });
        #   </script>
        #
        #   Sample for AJAX requests, the TextileEditor gets initialized without waiting for DOM.
        #   <script type="text/javascript">
        #     TextileEditor.initialize('article_body', 'extended');
        #     TextileEditor.initialize('article_body_excerpt', 'simple');
        #   </script>
        #
        def textile_editor_initialize(*dom_ids)
          options = {}

          # extract options from last argument if it's a hash
          if dom_ids.last.is_a?(Hash)
            hash = dom_ids.last.dup
            options.merge! hash
          end

          editor_ids     = (@textile_editor_ids || []) + textile_extract_dom_ids(*dom_ids)
          editor_buttons = (@textile_editor_buttons || [])
          output = []

          output << '<script type="text/javascript">'
          output << '/* <![CDATA[ */'

          unless request.xhr?
            output << %{jQuery(document).ready(function($) \{}
          end

          output << editor_buttons.join("\n") if editor_buttons.any?

          editor_ids.each do |editor_id, mode|
            output << %q{new TextileEditor('%s', '%s');} % [editor_id, mode || 'extended']
          end

          unless request.xhr?
            output << '});'
          end

          output << '/* ]]> */'
          output << '</script>'
          output.join("\n").html_safe
        end

        def textile_extract_dom_ids(*dom_ids)
          hash = dom_ids.last.is_a?(Hash) ? dom_ids.pop : {}
          hash.inject(dom_ids) do |ids, (object, fields)|
            ids + Array(fields).map { |field| "%s_%s" % [object, field] }
          end
        end
      end

    end
  end
end