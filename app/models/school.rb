class School < ActiveRecord::Base
  has_many :students

  def self.top_ten
    query = "SELECT schools.id, schools.name, COUNT(school_id) AS total_attendances FROM (SELECT students.name, students.school_id, COUNT(attendances.id) FROM attendances JOIN students ON attendances.student_id = students.id GROUP BY attendances.student_id, students.name, students.school_id) AS foo JOIN schools ON schools.id = foo.school_id GROUP BY schools.id, schools.name ORDER BY total_attendances DESC LIMIT 300;"

    ActiveRecord::Base.connection.execute(query).map do |school_hash|
      OpenStruct.new(school_hash)
    end

    # schools_hash = {}

    # School.all.each do |school|
    #   total_attendances = 0

    #   school.students.each do |student|
    #     total_attendances += student.attendances.count
    #   end

    #   schools_hash[school] = total_attendances
    # end

    # result = schools_hash.sort_by {|school, attendances| attendances}.reverse.to_h.keys[0..9]
  end
end
