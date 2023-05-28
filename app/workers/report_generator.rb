class ReportGenerator
    include Sidekiq::Worker
  
    def perform
        binding.pry
        report_data = generate_report_data
        report_path = generate_report_file(report_data)
    end

    def generate_report_data
        parcels = Parcel.includes(:sender, :receiver).all
    
        report_data = []
        parcels.each do |parcel|
          report_data << [
            parcel.id,
            parcel.weight.to_i,
            parcel.cost.to_i,
            parcel.status,
            parcel.sender.name,
            parcel.receiver.name
          ]
        end
    
        report_data
      end
    
      def generate_report_file(report_data)
        workbook = Axlsx::Package.new
        workbook.workbook.add_worksheet(name: 'Report') do |sheet|
          sheet.add_row(['Tracking Number', 'Weight', 'Cost', 'Status', 'Sender', 'Receiver'])
          report_data.each do |row|
            sheet.add_row(row)
          end
        end
    
        report_path = Rails.root.join('reports', "parcel_report_#{Time.current.strftime('%Y-%m-%d')}.xlsx")
        workbook.serialize(report_path)
    
        report_path
      end
  end