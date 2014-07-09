module RedCloth
  module Rails

    if defined?(::Rails) && ::Rails.version.to_f >= 3.1
      require 'redcloth-rails/engine'
    else
      raise 'Rails >= 3.1 is required'
    end

  end
end
