class SongsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :music]
  # before_action :correct_user, only: [:create, :destroy]
  before_action :set_song, only: [:show]

  def create
    puts "112233"
    @song = current_user.songs.new(song_params)
    if (@song.save!)
      puts "wild"
      @post = current_user.posts.new(post_params.merge(song_id: @song.id))
      if @post.save!
        redirect_to root_url
      end
    else
      render :new
    end
  end

  def edit
  end

  def new
    @song = Song.new

  end

  def destroy
  end

  def show
    @song = Song.find(params[:id])
  end

  def music
    @songs = Songs.all
    render "show_music"
  end

  def show_music
    @songs = Song.all

  end

  private

  def song_params
    params.require(:song).permit(:title, :text, :genre, :song_file, :user_id)

  end

  def set_song
    @song = Song.find(params[:id])
  end

  def post_params
    params.permit(:text)
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

end
