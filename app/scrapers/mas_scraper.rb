class MasScraper
  attr_accessor :accumulator

  def self.call(markup, domain, target)
    new(markup, domain, target).call { |scraper, translation| yield scraper, translation }
  end

  def initialize(markup, domain, target)
    @markup = markup
    @domain = domain
    @target = target
    @accumulator = []
  end

  def call
    document.css(target).each do |anchor|
      yield(self, SearchService::Translation.new(locale, ArticleParser.new(anchor, domain).call))
    end
    accumulator
  end

  def welsh_url(markup, target)
    domain + document(markup).css(target).first['href']
  end

  def welsh_title(markup, target)
    document(markup).css(target).first.text
  end

  def welsh_locale(markup)
    locale(markup)
  end

private

  attr_reader :markup, :domain, :target

  def document(given_markup = markup)
    Nokogiri::HTML(given_markup)
  end

  def locale(given_markup = markup)
    document(given_markup).css('html').attribute('lang').value.to_sym
  end

  class ArticleParser
    def initialize(anchor, domain)
      @anchor = anchor
      @domain = domain
    end

    def call
      SearchService::Article.new(title, url)
    end

  private

    attr_reader :anchor, :domain, :accumulator

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
