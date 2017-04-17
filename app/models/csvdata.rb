class Csvdata
	include ActiveModel::Model
	require 'CSV'

	EVENT_DATES = ["1/5/09", "2/2/09", "3/2/09", "4/6/09", "5/4/09", "6/1/09", "7/6/09", "8/3/09", "9/7/09", "10/5/09", "11/2/09", "12/7/09", "1/4/10", "2/1/10", "3/1/10", "4/5/10", "5/3/10", "6/7/10", "7/5/10", "8/2/10", "9/6/10", "10/4/10", "11/1/10", "12/6/10", "1/3/11", "2/7/11", "3/7/11", "4/4/11", "5/2/11", "6/6/11", "7/4/11", "8/1/11", "9/5/11", "10/3/11", "11/7/11", "12/4/11", "1/2/12", "2/6/12", "3/5/12", "4/2/12", "5/7/12", "6/4/12", "7/2/12", "8/6/12", "9/3/12", "10/1/12", "11/5/12", "12/3/12", "1/7/13", "2/4/13", "3/4/13", "4/1/13", "5/6/13", "6/3/13", "7/1/13", "8/5/13", "9/2/13", "10/7/13", "11/4/13", "12/2/13", "1/6/14", "2/3/14", "3/3/14", "4/7/14", "5/5/14", "6/2/14", "7/7/14", "8/4/14", "9/1/14", "10/6/14", "11/3/14", "12/1/14", "1/5/15", "2/2/15", "3/2/15", "4/6/15", "5/4/15", "6/1/15", "7/6/15", "8/3/15", "9/7/15", "10/5/15", "11/2/15", "12/7/15", "1/4/16", "2/1/16", "3/7/16", "4/4/16", "5/2/16", "6/6/16", "7/4/16", "8/1/16", "9/5/16", "10/3/16", "11/1/16", "12/5/16", "1/2/17", "2/6/17"]

	# Saves all previous Events based on the hard coded values from Excel
	def Csvdata.seedEvents
		EVENT_DATE.each do |date|
			debugger
			event = Event.new(date, "Free Movie Night")
			event.save
		end
	end

	# Looks through the CSV and saves a Student and their attendances based on their column values
	def Csvdata.seedStudents
		CSV.foreach("student_night.csv", {headers: true, return_headers: false}) do |row|

			student = Student.new(
			email: row["E-MAIL"],
			name: "#{row["FIRST NAME"]} #{row["LAST NAME"]}",
			school: row["SCHOOL"],
			year: row["YR"].to_i,
			zip: row["zip"],
			referral: 6
			)

			### somehow need to check for error messages and replace with stubbed values

			student.save

			attendances = Csvdata.attendanceDates(row)
			attendances.each do |attendance| 
				Attendance.new(student_id: student.id, event_id: Event.find_by(date: attendance).id) 
			end

		end
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
		debugger
		return dates
	end
end