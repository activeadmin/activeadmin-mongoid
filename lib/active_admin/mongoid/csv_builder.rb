module ActiveAdmin
  class CSVBuilder
    def build(controller, csv)
      @collection  = controller.send :find_collection, except: :pagination
      columns      = exec_columns controller.view_context
      options      = ActiveAdmin.application.csv_options.merge self.options
      bom          = options.delete :byte_order_mark
      column_names = options.delete(:column_names) { true }
      csv_options  = options.except :encoding_options, :humanize_name

      csv << bom if bom

      if column_names
        csv << CSV.generate_line(columns.map { |c| encode c.name, options }, csv_options)
      end

      (1..paginated_collection.total_pages).each do |page|
        paginated_collection(page).each do |resource|
          resource = controller.send :apply_decorator, resource
          csv << CSV.generate_line(build_row(resource, columns, options), csv_options)
        end
      end

      csv
    end
  end
end
