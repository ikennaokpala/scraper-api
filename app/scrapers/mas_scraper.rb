class MasScraper
  Translation = Struct.new(:locale, :article)
  def self.call(markup, domain, target)
    new(markup, domain, target).call
  end

  def initialize(markup, domain, target)
    @markup = markup
    @domain = domain
    @target = target
  end

  def call
    document.css(target).inject([]) do |accumulator, anchor|
      accumulator << Translation.new(locale, ArticleParser.new(anchor, domain).call)
      accumulator
    end
  end

private

  attr_reader :markup, :domain, :target

  def document
    Nokogiri::HTML(markup)
  end

  def locale
    document.css('html').attribute('lang').value.to_sym
  end

  class ArticleParser
    Article = Struct.new(:title, :url)

    def initialize(anchor, domain)
      @anchor = anchor
      @domain = domain
    end

    def call
      Article.new(title, url)
    end

  private

    attr_reader :anchor, :domain

    def url
      domain + anchor['href']
    end

    def title
      anchor
        .to_s
        .gsub(/<\/?[^>]*>/, " ")
        .squish
    end
  end
end
