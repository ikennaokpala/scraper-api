require 'rails_helper'

RSpec.describe SearchService do
  describe '#results' do
    let(:term) { 'Mortgages – a beginner’s guide' }
    let(:scraper) { MasScraper }
    let(:titles) { subject.flat_map { |translations| translations.values.map { |article| article.title} } }
    let(:search_params) { { status: 200, body: fixtures_file('search.html'), headers: {} } }
    let(:article_params) { { status: 200, body: fixtures_file('article.html'), headers: {} } }
    let(:welsh_article_params) { { status: 200, body: fixtures_file('welsh.html'), headers: {} } }
    let(:article_uri) { /https:\/\/#{uri.hostname}\/en\/(articles|categories)\/.*/ }
    let(:welsh_article_uri) { /https:\/\/#{uri.hostname}\/cy\/articles\/.*/ }
    let(:service) { described_class.new(term, scraper) }
    let(:uri) { service.search_uri }
    let(:locales) { subject.flat_map(&:keys).uniq }
    let(:headers) do
      {
        headers: {
         'Accept' => '*/*',
         'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Host' => uri.hostname,
         'User-Agent' => 'Ruby'
        }
      }
    end

    subject { service.results }

    before do
      stub_request(:get, uri).with(headers).to_return(search_params)
      stub_request(:get, article_uri).with(headers).to_return(article_params)
      stub_request(:get, welsh_article_uri).with(headers).to_return(welsh_article_params)
    end

    context 'user provides search term' do
      it 'returns article\'s with title and url for English and Welsh translations' do
        expect(locales).to include(:en)
        expect(locales).to include(:cy)
        expect(titles).to include(term)
        expect(subject.to_json).to match_response_schema('v1/articles/search/articles')
      end
    end
  end
end
