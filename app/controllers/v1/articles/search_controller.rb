class V1::Articles::SearchController < V1::BaseController
  def index
    render json: SearchService.results(params['term'])
  end
end
