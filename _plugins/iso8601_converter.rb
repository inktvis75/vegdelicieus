# iso8601_converter.rb
# A jekyll plugin to convert ISO 8601 format to epoch and minutes

require 'time'

module Jekyll
  module Iso8601Converter
    def iso8601_to_unix (input)
      Time.iso8601 (input).to_i.to_s
    end

    def iso8601_to_minutes (input)
      parts = input.to_s.split(/PT/)
      minutes = 0
      parts.each do |part|
        if part.include? "Y"
          minutes += part[/\d+Y/].to_i * 525600
        end
        if part.include? "D"
          minutes += part[/\d+D/].to_i * 1440
        end
        if part.include? "H"
          minutes += part[/\d+H/].to_i * 60
        end
        if part.include? "M"
          minutes += part[/\d+M/].to_i
        end
        if part.include? "S"
          minutes += part[/\d+S/].to_f / 60
        end
      end
      "%.0f" % minutes
    end
  end
end

Liquid::Template.register_filter (Jekyll::Iso8601Converter)
