require 'rails_helper'

RSpec.describe SearchService do
  describe '#results' do
    let(:term) { 'Mortgages – a beginner’s guide' }
    let(:scraper) { MasScraper }
    let(:titles) { subject.map { |translation| translation.article.title } }
    let(:return_params) { { status: 200, body: fixtures_file('search.html'), headers: {} } }
    let(:service) { described_class.new(term, scraper) }
    let(:uri) { service.search_uri }
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

    before { stub_request(:get, uri).with(headers).to_return(return_params) }

    context 'user provides search term' do
      it 'returns article\'s with title and url for English' do
        expect(subject.first.locale).to eq(:en)
        expect(titles).to include(term)
        expect(subject.to_json).to match_response_schema('v1/articles/search/articles')
      end
    end
  end
end
