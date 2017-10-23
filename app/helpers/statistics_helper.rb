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
  def events_per_location(location_id) 
    events = Event.where('events.location = #{location_id}')
    # return get_attendances_per_event(events)
  end

  # Gets the count of all attendances per location grouped by year
  def get_attendances_per_event(location_id)
    attendances_per_year_by_loc = @conn.exec("SELECT COUNT(*) as total, extract(year from date) as year FROM events JOIN attendances ON events.id = attendances.event_id WHERE events.location = #{location_id} GROUP BY year ORDER BY year DESC;")
    attends_by_year = {}
   
    attendances_per_year_by_loc.each do |attends|
      attends_by_year[attends['year']] = attends['total']
    end
    return attends_by_year
  end

  # Gets the number of unique students per location grouped by year
  def get_students_per_location(location_id)
    students_by_year = @conn.exec("SELECT COUNT(DISTINCT student_id) as students, extract(year from date) as year FROM attendances JOIN events ON attendances.event_id = events.id WHERE events.location = #{location_id} GROUP BY year ORDER BY year DESC;")
    unique_student_count = {}
  
    students_by_year.each do |unique_students|
      unique_student_count[unique_students['year']] = unique_students['students']
    end
    return unique_student_count
  end

  # Gets the number of unique schools per location grouped by year
  def get_schools_per_location(location_id)
    schools_by_year = @conn.exec("SELECT yyyy, COUNT(school_id) FROM (SELECT extract(year FROM events.date) AS yyyy, students.school_id FROM events JOIN attendances ON attendances.event_id = events.id JOIN students ON attendances.student_id = students.id WHERE events.location = #{location_id} GROUP BY students.school_id, yyyy) AS years_school_attendances GROUP BY yyyy;")
    schools_grouped = {}
    # SELECT DISTINCT school_id as school, extract(year from events.date) as yyyy FROM attendances JOIN events ON attendances.event_id = events.id JOIN students ON attendances.student_id = students.id WHERE events.location = 0;
    schools_by_year.each do |unique_schools|
      schools_grouped[unique_schools['yyyy']] = unique_schools['count']
    end 
    return schools_grouped
  end

  def build_school_hash(location_id)


  end




  def get_years_for_location(location_id)
    Event.where(location: location_id).map(&:date).map(&:year).uniq
  end

  def get_attends_for_location(location_id)
    Event.where(location: location_id).joins(:attendances).count
  end 

  def location_students(location_id)
    # Event.where(location: location_id).joins(:attendances).select('attendances.student_id').uniq.count
    @conn.exec("SELECT COUNT(DISTINCT attendances.student_id) FROM attendances JOIN events ON events.id = attendances.event_id WHERE events.location = #{location_id};")[0].values[0].to_i
  end

  def location_schools(location_id)
    Event.where(location: location_id).joins(:attendances => :student).select('students.school_id').uniq.count
  end

  def location_students_grouped(location_id)
    Event.where(location: location_id).joins(:attendances).group_by_year('attendances.created_at').select('attendances.student_id').uniq.count
  end

  def location_schools_grouped(location_id)
    Event.where(location: location_id).joins(:attendances => :student).group_by_year('attendances.created_at').select('students.school_id').uniq.count
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
