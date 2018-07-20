require 'active_admin/inputs/filters/select_input'

class ActiveAdmin::Inputs::Filters::SelectInput
  def searchable_method_name
    name = if searchable_has_many_through?
             "#{reflection.through_reflection.name}_#{reflection.foreign_key}"
           elsif reflection_searchable?
             reflection.key
           end
    (name == '_id') ? 'id' : name
  end
end
