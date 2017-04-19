class MoviesController < ApplicationController

	def update
		params[:movie].each do |key, movie|
			id = (key.to_i < 1491481669659) ? Movie.find(key) : nil 
			if movie[:delete] == "1" && id != nil
				delete(key)
			elsif id != nil
				edit(key, movie)
			elsif id == nil && !movie[:title].blank?
				save(movie)
			end
		end
		redirect_to(:back)
	end

	def save(movie)
		movie = Movie.new(movie_params(movie))
		movie.save
		flash[:notice] = "movie(s) saved"
	end

	def edit(key, movie)
		current_movie = Movie.find(key.to_i)
		current_movie.update_attributes(movie_params(movie))
		flash[:notice] = "Movie(s) edited"
	end

	def delete(key)
		movie = Movie.find(key.to_i)
		movie.delete
		flash[:alert] = "movie(s) deleted"
	end

	def movie_params(movie)
		movie.permit(:title, :time, :event_id)
	end

end


