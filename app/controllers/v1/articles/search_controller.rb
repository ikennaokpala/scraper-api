class V1::Articles::SearchController < V1::BaseController
  def index
    render json: SearchService.first_result_only(params['term'])
  end
end
