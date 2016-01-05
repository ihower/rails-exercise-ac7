class ApiV1::TopicsController < ApiController

  # GET /api/v1/topics/:id
  def show
    @topic = Topic.find(params[:id])

    # show.json.jbuilder
  end

  # GET /api/v1/topics
  def index
    @topics = Topic.page( params[:page] ).per(5)

    # index.json.jbuilder
  end

end
