class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :search, :top]

  # GET /movies
  # GET /movies.json
  def index
    if params[:search].present?
      @movies = Movie.titles_search(params[:search]).page(params[:page]).per(10)
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @movies = @tag.movies.order("created_at: :DESC").page(params[:page]).per(10)
    else
      @movies = Movie.includes(:user).order("created_at: :DESC").page(params[:page]).per(10)
    end
      @movies = Movie.includes(:user).order("created_at DESC").page(params[:page]).per(10)
      @tag_lists = Tag.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    # binding.pry
    @movie = Movie.new(movie_params)
    tag_list = params[:movie][:tag_name].to_s.split('nil')
    respond_to do |format|
      if @movie.save
        @movie.save_movies(tag_list)
        format.html { redirect_to @movie, notice: '投稿が完了しました' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: '更新しました' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: '削除しました' }
      format.json { head :no_content }
    end
  end

  def search
    @movies = Movie.search(params[:keyword]).page(params[:page]).per(10)
    @tag_names = Tag.search(params[:keyword]).page(params[:page]).per(10)
  end

  def top
  
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :content, :movie, tags_attributes: [:tag_name])
    end

    def move_to_index
      unless user_signed_in?
        redirect_to action: :index
      end
    end
end
