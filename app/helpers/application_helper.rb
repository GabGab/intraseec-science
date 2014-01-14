module ApplicationHelper
  include Mobvious::Rails::Helper

  def error_messages_for(*objects)
    objects.inject([]) do |acc, object|
      if defined?(object) && object && object.errors.any?
        errors = object.errors.full_messages.inject([]) do |acc, msg|
          acc << content_tag(:li, msg)
        end
        content_tag(:ul, raw(errors.join("\n")), :class => "object-errors")
      end
    end.try :html_safe
  end
end