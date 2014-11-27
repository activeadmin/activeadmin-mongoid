module ActiveAdmin
  module Filters
    module ViewHelper
      def active_admin_filters_form_for(search, filters, options = {})
        defaults = { :builder => ActiveAdmin::Filters::FormBuilder,
          :url => collection_path,
          :html => {:class => 'filter_form'} }
        required = { :html => {:method => :get},
          :as => :q }
        options  = defaults.deep_merge(options).deep_merge(required)

        form_for search.base.new, options do |f|
          search_filters_html = ""
          filters.each do |attribute, opts|
            next if opts.key?(:if)     && !call_method_or_proc_on(self, opts[:if])
            next if opts.key?(:unless) &&  call_method_or_proc_on(self, opts[:unless])
            search_filters_html += f.label(attribute.to_s, opts[:label])
            value = params.has_key?(:q) ? params[:q][attribute] : nil
            search_filters_html += f.text_field(attribute, opts.except(:if, :unless).merge(:value => value))
          end
          buttons = content_tag :div, :class => "buttons" do
            f.submit(I18n.t('active_admin.filters.buttons.filter')) +
              link_to(I18n.t('active_admin.filters.buttons.clear'), '#', :class => 'clear_filters_btn') +
              hidden_field_tags_for(params, :except => [:q, :page])
          end
          # form_buffers removed from main activeadmin branch
          # f.form_buffers.last + ::ActiveSupport::SafeBuffer.new(search_filters_html) + buttons
        end
      end
    end
  end
end
