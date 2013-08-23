class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @titleNotSorted = true
    @release_dateNotSorted = true
    @all_ratings = Movie.all_ratings
    @rr = params

    if params["ratings"].nil?
      ratings_filter = @all_ratings
    else
      ratings_filter = params["ratings"].keys
    end
    #debugger
    
    @checked = Movie.checked ratings_filter
    
    @movies = Movie.order(params[:sort]).find(:all,
           :conditions => { :rating => ratings_filter })
   
    if not params[:sort].nil?
      if params[:sort] == 'title'
        @titleNotSorted = false
      elsif params[:sort] == 'release_date'
        @release_dateNotSorted = false
      end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
