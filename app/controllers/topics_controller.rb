class TopicsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def about
  end

  def index
    @topics = Topic.order("id DESC").page( params[:page] )
  end

  def show
    @topic = Topic.find( params[:id] )
    @comment = Comment.new
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new( topic_params )
    @topic.user = current_user

    if @topic.save
      redirect_to topics_path
    else
      render :new
    end
  end

  protected

  def topic_params
    params.require(:topic).permit( :title, :content, :photo )
  end

end
