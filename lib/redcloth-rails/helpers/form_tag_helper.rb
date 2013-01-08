module RedCloth
  module Rails
    module Helpers

      module FormTagHelper
        # Creates a text input area; use a textarea for longer text inputs such as blog posts or descriptions
        # and includes the textile toolbar above it.
        #
        # @param [String] name
        # @param [String] content
        # @param [Hash]   options
        # @option options [String]  :size     String to specify the column and row dimensions (e.g., "25x10").
        # @option options [Integer] :rows     Specify the number of rows in the textarea
        # @option options [Integer] :cols     Specify the number of columns in the textarea
        # @option options [Boolean] :disabled If set to true, the user will not be able to use this input.
        #
        # Any other option (key/value pair) will be used to create HTML attributes for the tag.
        #
        #   Samples:
        #   textile_editor_tag 'post'
        #   # => <textarea id="post" name="post"></textarea>
        #
        #   textile_editor_tag 'bio', @user.bio
        #   # => <textarea id="bio" name="bio">This is my biography.</textarea>
        #
        #   textile_editor_tag 'body', nil, :rows => 10, :cols => 25
        #   # => <textarea cols="25" id="body" name="body" rows="10"></textarea>
        #
        #   textile_editor_tag 'body', nil, :size => "25x10"
        #   # => <textarea name="body" id="body" cols="25" rows="10"></textarea>
        #
        #   textile_editor_tag 'description', "Description goes here.", :disabled => true
        #   # => <textarea disabled="disabled" id="description" name="description">Description goes here.</textarea>
        #
        #   textile_editor_tag 'comment', nil, :class => 'comment_input'
        #   # => <textarea class="comment_input" id="comment" name="comment"></textarea>
        #
        def textile_editor_tag(name, content = nil, options = {})
          editor_id = options[:id] || name
          mode      = options.delete(:simple) ? 'simple' : 'extended'
          (@textile_editor_ids ||= []) << [editor_id.to_s, mode.to_s]

          text_area_tag(name, content, options)
        end
      end

    end
  end
end