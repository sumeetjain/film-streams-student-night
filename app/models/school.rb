class School < ActiveRecord::Base
  has_many :students

  def self.top_ten
    schools_hash = {}

    School.all.each do |school|
      total_attendances = 0

      school.students.each do |student|
        total_attendances += student.attendances.count
      end

      schools_hash[school] = total_attendances
    end

    result = schools_hash.sort_by {|school, attendances| attendances}.reverse.to_h.keys[0..9]
  end
end
