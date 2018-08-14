require 'net/http'

class SearchService
  DOMAIN = 'https://www.moneyadviceservice.org.uk'
  private_constant :DOMAIN

  def self.results(term, scraper = MasScraper)
    new(term, scraper).results
  end

  def initialize(term, scraper)
    @term = term
    @scraper = scraper
  end

  def results
    scraper.call(response_body, DOMAIN, 'main ol li a')
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
