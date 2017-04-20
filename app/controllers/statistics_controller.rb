class StatisticsController < ApplicationController
	include StatisticsHelper
	before_filter :set_dates

	def index
		@attendances = Event.new.total_student_attendances
		@years = Event.all.map(&:date).map(&:year).uniq
	end

	def show
		@events = Event.select(:id, :date).order(id: :desc)
		@event_years = Event.all.order(id: :desc).map(&:date).map(&:year).uniq
		@zipcodes = Student.joins(:attendances).select('students.zip').where("attendances.event_id = #{params[:id].to_i}").group(:zip).count
		@years = Student.joins(:attendances).select('students.year').where("attendances.event_id = #{params[:id].to_i}").group(:year).count.transform_keys { |k| Student.years.key(k) }
    @referrals = Student.joins(:attendances).select('students.referral').where("attendances.event_id = #{params[:id].to_i}").group(:referral).count.transform_keys { |k| Student.referrals.key(k) }
		@schools = Student.joins(:attendances, :school).where("attendances.event_id = #{params[:id].to_i}").group("schools.name").count
		@movies = Movie.joins(:attendances).select('movies.title').where("attendances.event_id = #{params[:id].to_i}").group(:title).count
  end

	def list
		@events = Event.select(:id, :date).order(id: :desc)
		@event_years = Event.all.order(id: :desc).map(&:date).map(&:year).uniq
	end

	def attendance
		@attendances = Event.new.total_student_attendances
		@years = Event.all.map(&:date).map(&:year).uniq
	end

	def all_time
		student_attends_by_year
		@events = Event.order(date: :desc).map(&:date).uniq
	end

	def by_date
		@students = student_attends_by_year
		@schools = schools_name_by_year
	end



  # ghetto
	def find_student
		@student = Student.find_by(:email => params[:id] + "." + params[:format])
		id = @student.id
		redirect_to("/statistics/student/#{id}")
	end


	# ghetto 
	def student
		@student = Student.find(params[:id])
	end
end