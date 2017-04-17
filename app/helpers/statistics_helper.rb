module StatisticsHelper

  # Totals by date
  def attendances_by_date
    line_chart attendances_by_date_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, height: '250px',
    xtitle: "Time", ytitle: "Attendances"
  end

  def referrals_by_date 
    column_chart referrals_by_date_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, donut: true, height: '250px',
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
    line_chart school_trends_charts_path(:start_date => @start_date, :end_date => @end_date), download: true, refresh: 60, height: '250px',
    xtitle: "Schools", ytitle: "Attendances"
  end 


  private
  def set_dates
    @start_date = params["start_date"] ? params["start_date"] : (Time.now.midnight - 365.day)
    @end_date = params["end_date"] ? params["end_date"] : (Time.now.midnight + 1.day)
  end

end
