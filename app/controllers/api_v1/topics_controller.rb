class ApiV1::TopicsController < ApiController

  before_action :authenticate_user!, :only => [:create]

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

  # POST /api/v1/topics
  def create
    @topic = Topic.new( :title => params[:title],
                        :content => params[:content] )
    @topic.user = current_user

    if @topic.save
      render :json => { :id => @topic.id, :message => "OK" }
    else
      render :json => { :message => "Invalid", :errors => @topic.errors }, :status => 400
    end
  end

end
