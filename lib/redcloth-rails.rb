unless defined?(RedCloth::Rails::Version)
  require File.join(File.dirname(__FILE__), 'redcloth-rails/version.rb')
end

module RedCloth
  module Rails

    if defined?(::Rails) && ::Rails.version.to_f >= 3.1
      require File.join(File.dirname(__FILE__), 'redcloth-rails/engine.rb')
    else
      raise 'Rails >= 3.1 is required'
    end

  end
end
