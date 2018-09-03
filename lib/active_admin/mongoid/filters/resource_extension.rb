require 'active_admin/filters/resource_extension'

module ActiveAdmin::Filters::ResourceExtension
  def default_association_filters
    if resource_class.respond_to?(:reflect_on_all_associations)
      without_embedded = resource_class.reflect_on_all_associations.reject { |e| [:embeds_many, :embeds_one].include? e.macro }
      poly, not_poly = without_embedded.partition{ |r| r.macro == :belongs_to && r.options[:polymorphic] }

      filters = poly.map(&:foreign_type) + not_poly.map(&:name)
      filters.map &:to_sym
    else
      []
    end
  end
end
