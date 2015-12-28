class CommentsController < ApplicationController

  before_action :set_topic
  before_action :authenticate_user!, :except => [:index, :show]

  def create
    @comment = Comment.new( comment_params )
    @comment.topic = @topic
    @comment.user = current_user
    if @comment.save
      redirect_to topic_path(@topic)
    else
      render "topics/show"
    end
  end

  protected

  def set_topic
    @topic = Topic.find( params[:topic_id] )
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
