class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :owned_post, only: [:edit, :update, :destroy]
    
    
    def index
        @posts = Post.all
    end
    
    def new
        @post = current_user.posts.build
    end
    
    def create
        @post = current_user.posts.build(post_params)
        
        if @post.save
            flash[:success] = "Your post has been created!"
            redirect_to posts_path
        else
            flash[:notice] = "Error. Post was not created."
            render :new
        end
    end
    
    def show
        #   being called in before_action above
    end
    
    def edit
        #   being called in before_action above
    end
    
    def update
        #   being called in before_action above
        if @post.update(post_params)
            redirect_to posts_path(@post)
            flash[:notice] = "Succesfully Edited Post!"
        else
            flash.now[:notice] = "Error. Post did was not updated."
            render :edit
        end
    end
    
    def destroy
       #   being called in before_action above
       @post.destroy
       
       redirect_to root_path
    end
    
    
    
    private
    def post_params
        params.require(:post).permit(:image, :caption)
    end
    
    def set_post
       @post = Post.find(params[:id]) 
    end
    
    def owned_post
        unless current_user == @post.user
            flash[:notice] = "That doesn't belong to you!"
            redirect_to root_path
        end
    end
end
