module StatisticsHelper

  # Totals by date
  def attendances_by_date
    line_chart attendances_by_date_charts_path(:start_date => @start_date, :end_date => @end_date, :time_period => @time_period), download: true, refresh: 60, height: '250px',
    xtitle: "Time", ytitle: "Attendances"
  end

  def attendances_all_time
    line_chart attendances_all_time_charts_path download: true, refresh: 60, height: '250px',
    xtitle: "Time", ytitle: "Attendances"
  end

  def referrals_by_date 
    bar_chart referrals_by_date_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, donut: true, height: '250px',
    xtitle: "Referrals", ytitle: "Referrals"
  end

  def movies_by_date 
    column_chart movies_by_date_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, height: '250px',
    xtitle: "Movies", ytitle: "Attendances"
  end

  def schools_by_date 
    column_chart schools_by_date_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, height: '250px',
    xtitle: "Schools", ytitle: "Attendances"
  end

  def school_trends
    column_chart school_trends_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, height: '250px',
    xtitle: "Movies", ytitle: "Attendances"
  end 

  def grade_by_date 
    column_chart grade_by_date_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, height: '250px',
    xtitle: "School Year", ytitle: "Attendances"
  end

  def zip_by_date 
    column_chart zip_by_date_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, height: '250px',
    xtitle: "Zip Codes", ytitle: "Attendances"
  end

  # Trends by date
  def school_trends
    Student.between_times(@start_date.to_date, @end_date.to_date).joins(:attendances).select('attendances.created_at').group('students.school').group_by_year('attendances.created_at').count.each { |k| k[0][0] = Student.schools.key(k[0][0]) }
  end 

  def referral_trends
    Student.between_times(@start_date.to_date, @end_date.to_date).joins(:attendances).select('attendances.created_at').group('students.referral').group_by_year('attendances.created_at').count.each { |k| k[0][0] = Student.referrals.key(k[0][0]) }
  end 

  def referral_trends
    Student.between_times(@start_date.to_date, @end_date.to_date).joins(:attendances).select('attendances.created_at').group('students.referral').group_by_year('attendances.created_at').count.each { |k| k[0][0] = Student.referrals.key(k[0][0]) }
  end 

  def event_list_by_year
    Event.by_year(@year).select(:id, :date).order(id: :desc)
  end

  def attends_by_student(id)
    Student.joins(:attendances).group_by_year('attendances.created_at').where(:attendances => { :student_id => id }).count
  end 


  def schools_name_by_year
    schools = Attendance.between_times(@start_date.to_date, @end_date.to_date).joins(:student => :school).order("count_all DESC").group("schools.name").count
  end

  def student_attends_by_year
    students = Attendance.between_times(@start_date.to_date, @end_date.to_date).joins(:student).group(:email, :name).count
    students.sort_by{|k,v| v}.reverse
  end

  private
  def set_dates
    @start_date = params["start_date"] ? params["start_date"] : (Time.now.midnight - 365.day)
    @end_date = params["end_date"] ? params["end_date"] : (Time.now.midnight + 1.day)
    @time_period = params["period"] ? params["period"] : "month"
    @year = params["year"] ? params["year"] : (Date.today.year)
  end

end
