# frozen_string_literal: true

module Jaaf::Components::Shared
  class MediumComponent < ViewComponent::Base
    attr_accessor :attachment, :variant, :autoplay, :css_class

    renders_one :preview_missing

    # attachment: ActiveStorage::Attached::One
    def initialize(attachment:, variant:, autoplay: false, css_class: nil)
      @attachment = attachment
      @variant = variant
      @autoplay = autoplay
      @css_class = css_class
    end

    def media?
      return false if attachment.blank?

      true
    end

    def image_src
      return if attachment.blank?
      return unless attachment.attached?

      if attachment.class != ActiveStorage::Attached::One
        raise "ActiveStorage::Attached::One required, got #{attachment.class}"
      end

      return url_for(attachment) unless variant

      url_for(attachment.variant(variant))
    rescue ActiveStorage::InvariableError
      url_for(attachment)
    end

    def render_media
      case attachment.content_type.split("/").first
      when "image"
        content_tag :img, nil, src: image_src, class: css_class
      when "video"
        content_tag :video, nil, src: image_src,
                                 controls: true,
                                 class: css_class,
                                 onmouseover: autoplay ? "this.play()" : nil,
                                 onmouseout: autoplay ? "this.pause()" : nil
      end
    end
  end
end
