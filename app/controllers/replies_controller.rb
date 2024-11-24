class RepliesController < ApplicationController
  before_action :set_reply, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create ]

  # GET /replies or /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1 or /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @post= Post.find(params[:format])
    @reply = @post.replies.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies or /replies.json
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.new(reply_params)

    if params[:reply][:parent_reply_id].present?
      @reply.parent_reply_id = params[:reply][:parent_reply_id]
    end

    respond_to do |format|
      if @reply.save
        format.html { redirect_to @post, notice: "Reply was successfully created." }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1 or /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply.post, notice: "Reply was successfully updated." }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1 or /replies/1.json
  def destroy
    @reply.destroy!

    respond_to do |format|
      format.html { redirect_to replies_path, status: :see_other, notice: "Reply was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_params
      params.require(:reply).permit(:text, :user_id, :post_id, :parent_reply_id)
    end
    def upvote
      vote = @reply.votes.find_or_initialize_by(user: current_user)
  
      if vote.new_record? || vote.value != 1
        vote.update(value: 1)
        flash[:notice] = "You upvoted the reply."
      else
        flash[:alert] = "You've already upvoted this reply."
      end
  
      redirect_to post_path(@reply.post)
    end
  
    def downvote
      vote = @reply.votes.find_or_initialize_by(user: current_user)
  
      if vote.new_record? || vote.value != -1
        vote.update(value: -1)
        flash[:notice] = "You downvoted the reply."
      else
        flash[:alert] = "You've already downvoted this reply."
      end
  
      redirect_to post_path(@reply.post)
    end
  
    private
  
    def set_reply
      @reply = Reply.find(params[:id])
    end
end
