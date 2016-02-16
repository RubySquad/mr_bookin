module BooksHelper
  def carousel_for(book_items)
    Carousel.new(self, book_items).html
  end

  class Carousel
    def initialize(view, book_items)
      @view = view
      @book_items = book_items
      @uid = SecureRandom.hex(6)
    end

    def html
      content = safe_join([indicators, slides, controls])
      content_tag(:div, content, id: uid, class: 'carousel slide')
    end

    private

    attr_accessor :view, :book_items, :uid
    delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

    def indicators
      items = book_items.count.times.map { |index| indicator_tag(index) }
      content_tag(:ol, safe_join(items), class: 'carousel-indicators')
    end

    def indicator_tag(index)
      options = {
        class: (index.zero? ? 'active' : ''),
        data: { 
          target: uid, 
          slide_to: index
        }
      }

      content_tag(:li, '', options)
    end

    def slides
      items = book_items.map.with_index { |book_item, index| slide_tag(book_item, index.zero?) }
      content_tag(:div, safe_join(items), class: 'carousel-inner')
    end

    def slide_tag(book_item, is_active)
      options = {
        class: (is_active ? 'item active' : 'item'),
      }

      content_tag(:div, options) do
        render(partial: 'card', object: book_item)
      end
    end

    def controls
      safe_join([control_tag('left'), control_tag('right')])
    end

    def control_tag(direction)
      options = {
        class: "#{direction} carousel-control",
        data: { slide: direction == 'left' ? 'prev' : 'next' }
      }

      icon = content_tag(:i, '', class: "glyphicon glyphicon-chevron-#{direction}")
      control = link_to(icon, "##{uid}", options)
    end
  end
end
