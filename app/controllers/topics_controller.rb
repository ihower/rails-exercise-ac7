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

    unless cookies["view-topic-#{@topic.id}"]
      cookies["view-topic-#{@topic.id}"] = "viewed"
      @topic.views_count += 1
      @topic.save!
    end

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

  # POST /topics/:id/subscribe
  def subscribe
    @topic = Topic.find( params[:id] )
    @topic.subscriptions.create!( :user => current_user )

    respond_to do |format|
      format.html{ redirect_to :back }
      format.js
    end
  end

  def unsubscribe
    @topic = Topic.find( params[:id] )
    current_user.subscriptions.where( :topic_id => @topic.id ).destroy_all

    respond_to do |format|
      format.html{ redirect_to :back }
      format.js { render "subscribe"}
    end
  end

  protected

  def topic_params
    params.require(:topic).permit( :title, :content, :photo )
  end

end
