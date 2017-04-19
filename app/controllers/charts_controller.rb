class ChartsController < ApplicationController

   # Total by date
  def attendances_by_date
    result = Attendance.between_times(params[:start_date].to_date, params[:end_date].to_date).group_by_year(:created_at).count
    render json: [{name: 'Attendances', data: result}]
  end

  def attendances_all_time
    result = Attendance.all.group_by_year(:created_at).count
    render json: [{name: 'Attendances', data: result}]
  end

  def referrals_by_date
    result = Student.between_times(params[:start_date].to_date, params[:end_date].to_date).joins(:attendances).select('students.referral').group(:referral).count.transform_keys { |k| Student.referrals.key(k) }
    render json: [{name: 'Referrals', data: result}]
  end

  def movies_by_date
    result = Movie.between_times(params[:start_date].to_date, params[:end_date].to_date).joins(:attendances).select('movies.title').group(:title).count
    render json: [{name: 'Movies', data: result}]
  end

  def schools_by_date
    result = Student.between_times(params[:start_date].to_date, params[:end_date].to_date).joins(:attendances).select('students.school').group(:school).count.transform_keys { |k| Student.schools.key(k) }
    render json: [{name: 'Schools', data: result}]
  end

  def grade_by_date
    result = Student.between_times(params[:start_date].to_date, params[:end_date].to_date).joins(:attendances).select('students.year').group(:year).count.transform_keys { |k| Student.years.key(k) }
    render json: [{name: 'School Year', data: result}]
  end

  def zip_by_date
    result = Student.between_times(params[:start_date].to_date, params[:end_date].to_date).joins(:attendances).select('students.zip').group(:zip).count
    render json: [{name: 'Zip code', data: result}]
  end

end
