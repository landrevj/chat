module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    include Redcarpet::Render::SmartyPants

    # youtube auto embedding from https://stackoverflow.com/questions/23051568/how-to-embed-a-youtube-video-in-markdown-with-redcarpet-for-rails
    def autolink(link, link_type)
      case link_type
        when :url then url_link(link)
        when :email then email_link(link)
      end
    end

    def url_link(link)
      case link
        # regex from https://gist.github.com/afeld/1254889
        when /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/ then youtube_link(link)
        else normal_link(link)
      end
    end

    def youtube_link(link)
      video_id = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/.match(link)[1]
      "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube-nocookie.com/embed/#{video_id}?rel=0\" frameborder=\"0\" allowfullscreen></iframe>"
    end

    def normal_link(link)
      "<a href=\"#{link}\">#{link}</a>"
    end

    def email_link(email)
      "<a href=\"mailto:#{email}\">#{email}</a>"
    end
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      no_images:       true,
      space_after_headers: true,
    }

    extensions = {
      autolink:           true,
      strikethrough:      true,
      underline:          true,
      highlight:          true,
      no_intra_emphasis:  true,
      superscript:        true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
    }

    renderer = HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
