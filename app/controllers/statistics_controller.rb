class StatisticsController < ApplicationController
	include StatisticsHelper
	before_filter :set_dates

	def index
		@attendances = Attendance.count
		@unique_students = Attendance.all.group_by_year(:created_at).select(:student_id).uniq.count
		@years = Event.all.map(&:date).map(&:year).uniq
		@students = Attendance.all.group_by_year(:created_at).select(:student_id).uniq.count
		@unique_schools = Attendance.group_by_year('attendances.created_at').joins(:student => :school).select('schools.name').uniq.count

	end
  
	def show
		@event_info = Event.find(params[:id])
		@events = Event.select(:id, :date).order(id: :desc)
		@event_years = Event.all.order(id: :desc).map(&:date).map(&:year).uniq
		@zipcodes = Student.joins(:attendances).select('students.zip').where("attendances.event_id = #{params[:id].to_i}").group(:zip).count
		@years = Student.joins(:attendances).select('students.year').where("attendances.event_id = #{params[:id].to_i}").group(:year).count.transform_keys { |k| Student.years.key(k) }
    	# TODO: Working here to replace @referrals value with new query
    @referrals = Student.joins(:attendances).select('students.referral').where("attendances.event_id = #{params[:id].to_i}").group(:referral).count.transform_keys { |k| Student.referrals.key(k) }
		@schools = Student.joins(:attendances, :school).where("attendances.event_id = #{params[:id].to_i}").group("schools.name").count
		@movies = Movie.joins(:attendances).select('movies.title').where("attendances.event_id = #{params[:id].to_i}").group(:title).count
  end

	def list
		@events = Event.order(date: :desc).map(&:date).uniq
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

	def student
		@student = Student.find(params[:id])
	end
	
	def school
		@uniq_schools = uniq_schools_by_id(params[:id])
		@attendances= schools_by_id(params[:id])
		@school = School.find(params[:id])
	end
end