class ActiveAdmin::Filters::FormBuilder
  def filter(method, options = {})
    if method.present? && options[:as] ||= default_input_type(method)
      template.concat input(method, options)
    end
  end

  def default_input_type(method, _options = {})
    if column = column_for(method)
      case column.type.name.downcase.to_sym
      when :date, :datetime, :time then :date_range
      when :string, :text, :object then :string
      when :float, :decimal then :numeric
      when :integer
        return :select if reflection_for(method.to_s.gsub('_id', '').to_sym)

        :numeric
      end
    elsif is_association?(method)
      :select
    else
      # dirty but allows to create filters for hashes
      :string
    end
  end

  def is_association?(method)
    @object.klass.associations.to_a.map(&:first).include?(method.to_s)
  end

  def column_for(method)
    @object.klass.fields[method.to_s] if @object.klass.respond_to?(:fields)
  end

  def reflection_for(method)
    @object.klass.reflect_on_association(method) if @object.klass.respond_to?(:reflect_on_association)
  end
end
