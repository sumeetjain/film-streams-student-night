class StatisticsController < ApplicationController
	include StatisticsHelper
	before_filter :set_dates

	def index
		@years = Event.all.map(&:date).map(&:year).uniq
		@events = Event.order(date: :desc).map(&:date).uniq
	end

	def show
		@zipcodes = Student.joins(:attendances).select('students.zip').where("attendances.event_id = #{params[:id].to_i}").group(:zip).count
		@years = Student.joins(:attendances).select('students.year').where("attendances.event_id = #{params[:id].to_i}").group(:year).count.transform_keys { |k| Student.years.key(k) }
    @referrals = Student.joins(:attendances).select('students.referral').where("attendances.event_id = #{params[:id].to_i}").group(:referral).count.transform_keys { |k| Student.referrals.key(k) }
		@schools = Student.joins(:attendances).select('students.school').where("attendances.event_id = #{params[:id].to_i}").group(:school).count.transform_keys { |k| Student.schools.key(k) }
		@movies = Movie.joins(:attendances).select('movies.title').where("attendances.event_id = #{params[:id].to_i}").group(:title).count
    
		Student.joins(:attendances).select('attendances.created_at').group('students.school').group_by_month('attendances.created_at').count.transform_keys{ |k| k[0] = Student.schools.key(k[0]) }
	end


end

