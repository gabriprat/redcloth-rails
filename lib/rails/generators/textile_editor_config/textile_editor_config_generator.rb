class TextileEditorConfigGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_javascript
    copy_file 'textile-editor-config.js.coffee.erb', 'app/assets/javascripts/textile-editor-config.js.coffee.erb'
  end

end
 
