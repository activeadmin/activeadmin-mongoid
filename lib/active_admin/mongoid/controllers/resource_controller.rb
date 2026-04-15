require 'active_admin/engine'

ActiveAdmin::Engine.module_eval do
  initializer 'active_admin.mongoid.resource_controller' do
    class ActiveAdmin::ResourceController
      def build_new_resource
        scoped_collection.send(
          method_for_build,
          # *resource_params
        )
      end
    end
  end
end
