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

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js # destroy.js.erb
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:content)
  end

end
