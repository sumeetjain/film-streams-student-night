module StatisticsHelper

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

  def schools_by_id(id)
    Attendance.joins(:student).where("students.school_id = #{id}").all.group_by_year("attendances.created_at").select(:student_id).count
  end 

  def uniq_schools_by_id(id)
    Attendance.joins(:student).where("students.school_id = #{id}").all.group_by_year("attendances.created_at").select(:student_id).uniq.count
  end

  def schools_name_by_year
    schools = Attendance.between_times(@start_date.to_date, @end_date.to_date).joins(:student => :school).order("count_all DESC").group("schools.name", "students.school_id").count
  end

  def student_attends_by_year
    students = Attendance.between_times(@start_date.to_date, @end_date.to_date).joins(:student).group(:email, :name, 'attendances.student_id').count
    students.sort_by{|k,v| v}.reverse
  end

  # My work starts here

  def attends_by_location(location)
    @conn = PGconn.connect(:dbname =>  "film-streams-student-night_development")
    @get_attends_by_location = @conn.exec("SELECT * FROM attendances JOIN events ON attendances.event_id = events.id WHERE events.location = #{location}")
    return @get_attends_by_location
  end

  # Gets all the events for a given location
  # TODO: Remove static location
  # based off school by id
  def events_per_location 

    events = Event.where('events.location = 0')
    # return get_attendances_per_event(events)
  end

  # Gets the count of all attendances per location grouped by year
  def get_attendances_per_event
    "SELECT COUNT(*) as total, extract(year from date) as yyyy FROM events JOIN attendances ON events.id = attendances.event_id WHERE events.location = 0 GROUP BY yyyy ORDER BY yyyy DESC;"
  end

  def print_referral_types(referrals)
    student_referrals = []
    referrals.each do |referral|
      student_referrals.push(referral.referral_type)
    end
    return student_referrals.join(", ")
  end

  private
  def set_dates
    @start_date = params["start_date"] ? params["start_date"] : (Time.now.midnight - 365.day)
    @end_date = params["end_date"] ? params["end_date"] : (Time.now.midnight + 1.day)
    @time_period = params["period"] ? params["period"] : "month"
    @year = params["year"] ? params["year"] : (Date.today.year)
  end

end
