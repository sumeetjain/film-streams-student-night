class StatisticsController < ApplicationController
	include StatisticsHelper
	before_filter :set_dates

	def index
		@conn = PGconn.connect(:dbname =>  "film-streams-student-night_development")
		
	    @attendances = Attendance.count
		@unique_students = Attendance.all.group_by_year(:created_at).select(:student_id).uniq.count
		@years = Event.all.map(&:date).map(&:year).uniq
		@students = Attendance.all.group_by_year(:created_at).select(:student_id).uniq.count
		@unique_schools = Attendance.group_by_year('attendances.created_at').joins(:student => :school).select('schools.name').uniq.count
		@referrals = Referral.select('referrals.id').group('referrals.referral_type').count.transform_keys { |k| Referral.referral_types.key(k) }
		
	# mine
		@years_for_ruth_sokolof = Event.where(location: 0 ).map(&:date).map(&:year).uniq
		@years_for_the_dundee = Event.where(location: 1 ).map(&:date).map(&:year).uniq
		@events_by_location = events_per_location
		# total attendaces/students per loc
		@location_attends = Event.where(location: 0).joins(:attendances).count
	    @location_students = Event.where(location: 0).joins(:attendances).select('attendances.student_id').uniq.count
	    @location_students_grouped = Event.where(location: 0).joins(:attendances).group_by_year('attendances.created_at').select('attendances.student_id').uniq.count

	    @location_schools = Event.where(location: 0).joins(:attendances => :student).select('students.school_id').uniq.count
		binding.pry	

		somestuff = ''
	end
  
	def show
		@event_info = Event.find(params[:id])
		@events = Event.select(:id, :date).order(id: :desc)
		@event_years = Event.all.order(id: :desc).map(&:date).map(&:year).uniq
		@zipcodes = Student.joins(:attendances).select('students.zip').where("attendances.event_id = #{params[:id].to_i}").group(:zip).count
		@years = Student.joins(:attendances).select('students.year').where("attendances.event_id = #{params[:id].to_i}").group(:year).count.transform_keys { |k| Student.years.key(k) }
    	@schools = Student.joins(:attendances, :school).where("attendances.event_id = #{params[:id].to_i}").group("schools.name").count
		@movies = Movie.joins(:attendances).select('movies.title').where("attendances.event_id = #{params[:id].to_i}").group(:title).count
	    @referrals = Referral.get_referrals_by_event(params[:id])
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