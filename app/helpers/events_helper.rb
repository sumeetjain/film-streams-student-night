module EventsHelper

	  # Database queries for reports
  def year_student_attendances(year)
    Attendance.by_year(year).select(:student_id).count
  end

  def total_student_attendances
    Attendance.select(:student_id).count
  end

  def unique_student_attendances(year)
    Attendance.by_year(year).select(:student_id).uniq.count
  end

  def unique_schools(year)
    Attendance.by_year(year).joins(:student).select('students.school').uniq.count
  end

  def school_by_event(date)
  	events = Attendance.by_day(date).joins(:student).select('students.school').uniq.count
  end

  def students_by_event(date)
    events = Attendance.by_day(date).joins(:student).select('students.id').uniq.count
  end

  def school_all_time_attendances
  	schools = Student.joins(:attendances).select('students.school').group(:school).count.transform_keys { |k| Student.schools.key(k) }
  	schools.sort_by{|k,v| v}.reverse
  end

end
