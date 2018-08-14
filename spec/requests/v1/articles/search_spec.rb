require 'rails_helper'

RSpec.describe '/v1/articles/search' do
  describe 'GET /v1/articles/search' do
    let(:search_params) { { status: 200, body: fixtures_file('search.html'), headers: {} } }
    let(:article_params) { { status: 200, body: fixtures_file('article.html'), headers: {} } }
    let(:welsh_article_params) { { status: 200, body: fixtures_file('welsh.html'), headers: {} } }
    let(:term) { URI.encode('Mortgages – a beginner’s guide') }
    let(:article_uri) { /https:\/\/www.moneyadviceservice.org.uk\/en\/(articles|categories)\/.*/ }
    let(:welsh_article_uri) { /https:\/\/www.moneyadviceservice.org.uk\/cy\/articles\/.*/ }
    let(:uri) { /https:\/\/www.moneyadviceservice.org.uk\/en\/search\?query=.*/ }
    let(:headers) do
      {
        headers: {
         'Accept' => '*/*',
         'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Host' => 'www.moneyadviceservice.org.uk',
         'User-Agent' => 'Ruby'
        }
      }
    end

    before do
      stub_request(:get, uri).with(headers).to_return(search_params)
      stub_request(:get, article_uri).with(headers).to_return(article_params)
      stub_request(:get, welsh_article_uri).with(headers).to_return(welsh_article_params)
      get '/v1/articles/search?term=' + term
    end

    it 'performs request successfully' do
      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('v1/articles/search/articles')
    end
  end
end
