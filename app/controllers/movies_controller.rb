class MoviesController < ApplicationController


	def update

		debugger

	end

		def update
		event = Event.find(params[:id])
		params[:movie].each do |key, movie|
			id = (key.to_i < 1491481669659) ? Movie.find(key) : nil 
			if movie[:delete] == "1" && id != nil
				delete(key)
			elsif id != nil
				edit(key, movie)
			elsif id == nil && !movie[:name].blank?
				save(movie)
			end
		end
	end


	def save(movie)
		movie = Movie.new(movie_params(movie))
		movie.save
		flash[:success] = "movie(s) saved"
	end

	def edit(key, movie)
		movie = Movie.find(key.to_i)
		movie.update_attributes(movie_params(item))
		flash[:success] = "Movie(s) edited"
	end

	def movie_params(movie)
		movie.permit(:title, :time)
	end

end


