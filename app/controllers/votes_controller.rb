class VotesController < ApplicationController
    before_action :authenticate_user! 
  
    def create
        @post = Post.find(params[:post_id])
        @vote = @post.votes.find_or_initialize_by(user: current_user)
        
        if @vote.new_record? || @vote.vote_type != vote_params[:vote_type]
          @vote.vote_type = vote_params[:vote_type]
          if @vote.save
            redirect_to @post, notice: 'Your vote has been cast.'
          else
            redirect_to @post, alert: 'An error occurred while casting your vote.'
          end
        else
          redirect_to @post, alert: 'You have already voted on this post.'
        end
    end
      
  
    def destroy
      @post = Post.find(params[:post_id])
      @vote = @post.votes.find_by(user: current_user)
  
      if @vote
        @vote.destroy
        redirect_to @post, notice: 'Your vote has been removed.'
      else
        redirect_to @post, alert: 'You haven’t voted on this post.'
      end
    end
  
    private
  
    def vote_params
      params.require(:vote).permit(:vote_type)
    end
  end
  