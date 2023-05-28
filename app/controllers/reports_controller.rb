class ReportsController < ApplicationController
    def view_report
      report_path = Rails.root.join('reports', "parcel_report_#{Time.current.strftime('%Y-%m-%d')}.xlsx")

      respond_to do |format|
        format.xlsx do
          send_file report_path, filename: "daily_report_#{Date.current}.xlsx", disposition: 'attachment'
        end
      end
    end
  end