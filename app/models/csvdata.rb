class Csvdata
	include ActiveModel::Model
	require 'CSV'

	EVENT_DATES = ["1/5/2009", "2/2/2009", "3/2/2009", "4/6/2009", "5/4/2009", "6/1/2009", "7/6/2009", "8/3/2009", "9/7/2009", "10/5/2009", "11/2/2009", "12/7/2009", "1/4/2010", "2/1/2010", "3/1/2010", "4/5/2010", "5/3/2010", "6/7/2010", "7/5/2010", "8/2/2010", "9/6/2010", "10/4/2010", "11/1/2010", "12/6/2010", "1/3/2011", "2/7/2011", "3/7/2011", "4/4/2011", "5/2/2011", "6/6/2011", "7/4/2011", "8/1/2011", "9/5/2011", "10/3/2011", "11/7/2011", "12/4/2011", "1/2/2012", "2/6/2012", "3/5/2012", "4/2/2012", "5/7/2012", "6/4/2012", "7/2/2012", "8/6/2012", "9/3/2012", "10/1/2012", "11/5/2012", "12/3/2012", "1/7/2013", "2/4/2013", "3/4/2013", "4/1/2013", "5/6/2013", "6/3/2013", "7/1/2013", "8/5/2013", "9/2/2013", "10/7/2013", "11/4/2013", "12/2/2013", "1/6/2014", "2/3/2014", "3/3/2014", "4/7/2014", "5/5/2014", "6/2/2014", "7/7/2014", "8/4/2014", "9/1/2014", "10/6/2014", "11/3/2014", "12/1/2014", "1/5/2015", "2/2/2015", "3/2/2015", "4/6/2015", "5/4/2015", "6/1/2015", "7/6/2015", "8/3/2015", "9/7/2015", "10/5/2015", "11/2/2015", "12/7/2015", "1/4/2016", "2/1/2016", "3/7/2016", "4/4/2016", "5/2/2016", "6/6/2016", "7/4/2016", "8/1/2016", "9/5/2016", "10/3/2016", "11/1/2016", "12/5/2016", "1/2/2017", "2/6/2017"]

	# Saves all previous Events based on the hard coded values from Excel
	#
	# run it one time to populate the PG database with these events
	def Csvdata.seedEvents
		EVENT_DATES.each do |date|
			event = Event.new(date: date, title: "Free Movie Night", created_at: date, updated_at: date)
			event.save
		end
	end

	# Looks through the CSV and saves a Student and their attendances based on their column values
	#
	# Run this to populate the CSV with all previus students and their attendances on dates.
	def Csvdata.seedStudents
		CSV.foreach("student_night.csv", {headers: true, return_headers: false}) do |row|

			student = Student.new(
			email: row["E-MAIL"],
			name: "#{row["FIRST NAME"]} #{row["LAST NAME"]}",
			school: Csvdata.set_valid_school(row["SCHOOL"]),
			year: Csvdata.set_valid_year(row["YR"].to_i),
			zip: row["zip"],
			referral: 6
			)

			student.save
			creation_date = Csvdata.save_student_attendances(row, student)
			debugger
			student.update(created_at: Csvdata.convert(creation_date), updated_at: Csvdata.convert(creation_date))			
		end
	end

	# Give a student object and row, records all their attendances into database
	#
	# student - Student , row - csv row
	#
	# saves all attendances to an event, returns first attendance
	def Csvdata.save_student_attendances(row, student)

			attendances = Csvdata.attendanceDates(row)

			attendances.each do |attendance| 
				new_att = Attendance.new(student_id: student.id,
													 			 event_id: Event.find_by(date: Csvdata.convert(attendance)).id)
				new_att.save
			end
			return attendances[0]
	end

	# Given a row looks through each header value to see if value is 1
	#
	# 1 is the indication within a column whether a student attended
	#
	# returns an array of dates on which a student attended Student Film Night
	def Csvdata.attendanceDates(row)
		dates = []
		row.headers.each do |header|
			dates << header if row[header] == "1"
		end
		return dates
	end

	# Takes a date that looks like "3/4/10" and transforms it "2010-04-10"
	def Csvdata.convert(attendance)
		attendance = attendance.split("/")
		attendance = Time.new("20" + attendance[2],
																 attendance[1],
																 attendance[0])
		attendance = attendance.strftime("%F")
	end

	# If a school is a valid enum, returns it, otherwise set to "other school"
	def Csvdata.set_valid_school(school)
		(Student.schools.keys.include? school) ? school : "other school"
	end

	def Csvdata.set_valid_year(year)
		(Student.years.keys.include? year)? year : "other"
	end

end