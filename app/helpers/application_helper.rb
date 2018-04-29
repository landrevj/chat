module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  
  # Custom renderer for Redcarpet
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    include Redcarpet::Render::SmartyPants
    
    # Custom support for spoilers
    def block_quote(quote)
      if quote.gsub!(/(?<=<p>)\s*!\s*/, ' ')
        "<blockquote class='spoiler'> #{quote}</blockquote>"
      else
        "<blockquote> #{quote}</blockquote>"
      end
    end
    
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
  
  # Apply custom markdown here
  def custom_markdown(text)
    wrap_quotes(text)
  end
  
  # Detect custom root and child post text references
  # @##12 matches root post ##12
  # @#12 matches child post #12
  def wrap_quotes(text)
    text.gsub(/@(#+)(\d+)/) do
    begin
      id = $2.to_i
      if $1 == '##'
        root_post = RootPost.find(id)
        board = root_post.board.abbreviation
        subject = current_user.id == root_post.user.id ? ' (OP | You)' : ' (OP)'
        "<a class='quote root-quote' href='/#{board}/threads/#{$2}' id='#{id}'>@#{$1 + $2 + subject}</a>"
      elsif $1 == '#'
        child_post = ChildPost.find(id)
        board = child_post.root_post.board.abbreviation
        thread_id = child_post.root_post.id
        subject = current_user.id == child_post.user.id ? ' (You)' : ''
        
        "<a class='quote child-quote' href='/#{board}/threads/#{thread_id}##{$2}' id='#{id}'>@#{$1 + $2 + subject}</a>"
      end
      rescue ActiveRecord::RecordNotFound
        "<a class='quote'>@#{$1 + $2} (Broken)</a>"
      end
    end
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      no_images:       true,
      space_after_headers: true,
      safe_links_only: true,
    }
    
    extensions = {
      autolink:           true,
      strikethrough:      true,
      underline:          true,
      highlight:          true,
      no_intra_emphasis:  true,
      superscript:        true,
      tables:             true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
    }
    
    renderer = HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    
    custom_markdown(markdown.render(text)).html_safe
  end

  def replies(post)
    content_tag :div, class: 'replies' do
      r = ''
      post.root_reply_ids.collect do |id|
        r += content_tag :div, class: ['root-reply', 'reply'], id: id do
          begin
            p = RootPost.find(id)
            content_tag :a, class: 'live-link', href: board_root_post_url(p.board, p) do
              content_tag :i, 'reply_all', class: 'material-icons'
            end
          rescue ActiveRecord::RecordNotFound
            content_tag :a, class: 'dead-link', title: 'dead link' do
              content_tag :i, 'error', class: 'material-icons'
            end
          end
        end
      end
      post.child_reply_ids.collect do |id|
        r += content_tag :div, class: ['child-reply', 'reply'], id: id do
          begin
            p = ChildPost.find(id)
            content_tag :a, class: 'live-link', href: board_root_post_url(p.root_post.board, p.root_post) + '#' + p.id.to_s do
              content_tag :i, 'reply', class: 'material-icons'
            end
          rescue ActiveRecord::RecordNotFound
            content_tag :a, class: 'dead-link', title: 'dead link' do
              content_tag :i, 'error', class: 'material-icons'
            end
          end
        end
      end
      r.html_safe
    end
  end

  def flash_class(key)
    case key
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-error"
      when 'alert' then "alert alert-error"
    end
  end
end
