require 'active_admin/filters/resource_extension'

module ActiveAdmin::Filters::ResourceExtension
  def default_association_filters
    if resource_class.respond_to?(:reflect_on_all_associations)
      poly, not_poly = resource_class.reflect_on_all_associations.partition{ |r| r.macro == :belongs_to && r.options[:polymorphic] }

      # remove deeply nested associations
      #not_poly.reject!{ |r| r.chain.length > 2 }

      filters = poly.map(&:foreign_type) + not_poly.map(&:name)
      filters.map &:to_sym
    else
      []
    end
  end
end
