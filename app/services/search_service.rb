require 'net/http'

class SearchService
  Translation = Struct.new(:locale, :article)
  Article = Struct.new(:title, :url)

  DOMAIN = 'https://www.moneyadviceservice.org.uk'
  private_constant :DOMAIN

  def self.results(term, scraper = MasScraper)
    new(term, scraper).results
  end

  def self.first_result_only(term)
    results(term).first
  end

  def initialize(term, scraper = MasScraper)
    @term = term
    @scraper = scraper
  end

  def results
    scraper.call(response_body, DOMAIN, 'main ol li a') do |current_scraper, translation|
      welsh_url = current_scraper.welsh_url(response_body(URI(translation.article.url)), 'header a.t-cy-link')

      welsh_markup = response_body(URI(welsh_url))
      welsh_title = current_scraper.welsh_title(welsh_markup, 'main h1')
      welsh_locale = current_scraper.welsh_locale(welsh_markup)

      current_scraper.accumulator << { translation.locale => translation.article, welsh_locale => Article.new(welsh_title, welsh_url) }
    end
  end

  def search_uri
    @search_uri ||= URI(DOMAIN + '/en/search?query=' + URI.encode(term))
  end

private

  attr_reader :term, :scraper

  def response_body(uri = search_uri)
    Net::HTTP.get_response(uri).body
  end
end
