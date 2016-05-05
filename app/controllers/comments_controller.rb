class CommentsController < ApplicationController
  before_filter :get_parent , :except => [:deletecomments]
   
  def new
    @comment = @parent.comments.build
  end
  
  def deletecomments
  	debugger
    if Comment.find_by_commentable_id(params[:id])==nil
       Comment.destroy(params[:id])
       flash[:alert]="comment delete.."
       redirect_to root_path
    else
    	flash[:alert]="comment is nested can'not delete it."
    	redirect_to root_path
    end
  end

  def create
    @comment = @parent.comments.build(title: params[:comment][:title],body: params[:comment][:body],user_id: current_user.id)
    if @comment.save
      redirect_to article_path(@comment.article), :notice => 'Thank you for your comment!'
    else
      render :new
    end
  end
 
  protected
   
  def get_parent

    @parent = Article.find_by_id(params[:article_id]) if params[:article_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    redirect_to root_path unless defined?(@parent)
  end
end

