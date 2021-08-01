require 'active_admin/mongoid'
require "rails/generators/actions"
require "rails/generators/named_base"

# Considering the Rails::Generators::NamedBase is one of the nearest ancestor to
# ActiveAdmin::Generators::InstallGenerator, we can open the class and an empty create_migration
# to the class(which will overridden by other subclasses). We can specifically focus on the
# ActiveAdmin::Generators::InstallGenerator class and apply remove_method during the method_added call
# and thereby pushing ActiveAdmin::Generators::InstallGenerator to use our empty create_migrations method.

Rails::Generators::NamedBase.class_eval do
  def create_migrations
  end

  def self.inherited(klass)
    super
    if klass.name == "ActiveAdmin::Generators::InstallGenerator"

      klass.class_eval do
        def self.method_added(method_name)
          super
          remove_method method_name if method_name == :create_migrations
        end
      end
    end
  end
end
