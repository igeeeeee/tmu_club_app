class Api::V1::PostsController < ApplicationController
    before_action :set_post, only: %i[ show edit update destroy ]

    # GET /posts or /posts.json
    def index
      posts = Post.all
      render json: { status: 'SUCCESS', message: 'Loaded posts', data: posts }
    end

    # GET /posts/1 or /posts/1.json
    def show
      @post = Post.where(id: params[:id])
      @user = User.find_by(id: @post.user_id)
    end

    # GET /posts/new
    def new
      @post = Post.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts or /posts.json
    def create
      @post = Post.new(
        content: params[:content],
        title: params[:title],
        user_id: @current_user.id
      )
      if @post.save
        render json: { status: 'SUCCESS', message: 'Saved post', data: @post }
      end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        render json: { status: 'SUCCESS', message: 'Saved post', data: @post }
      end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
      Post.find(params[:id]).destroy
      render json: { status: 'SUCCESS', message: 'Removed post' }
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.fetch(:post, {}).permit(
          :title, :content, :user_id
        )
      end
  end
