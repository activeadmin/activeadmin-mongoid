require 'active_admin/inputs/filters/select_input'

class ActiveAdmin::Inputs::Filters::SelectInput
  def searchable_method_name
    if searchable_has_many_through?
      "#{reflection.through_reflection.name}_#{reflection.foreign_key}"
    else
      reflection&.key || method
    end
  end

  def input_name
    return method if seems_searchable?

    searchable_method_name&.to_s + (multiple? ? '_in' : '_eq')
  end
end
