class CommentsController < ApplicationController
    before_action :set_post
    
    def create
        @comment = @post.comments.build(comment_params)
        @comment_user_id = current_user.id
        
        if @comment.save
            flash[:notice] = "Take that post!"
            redirect_to :back
        else
            flash[:notice] = "Massive comment fail"
            render root_path
        end
    end
    
    def destroy
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        flash[:notice] = "Comment successfully removed"
        redirect_to :root_path
    end


    private
        def comment_params
           params.require(:comment).permit(:content) 
        end
        
        def set_post
            @post = Post.find(params[:post_id])
        end

end
