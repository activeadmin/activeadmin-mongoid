require 'active_admin/inputs/filters/check_boxes_input'

class ActiveAdmin::Inputs::Filters::CheckBoxesInput
  def searchable_method_name
    if searchable_has_many_through?
      "#{reflection.through_reflection.name}_#{reflection.foreign_key}"
    else
      reflection.key || method
    end
  end
end
