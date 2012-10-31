require 'generators/active_admin/install/install_generator'
puts 'patch'
class ActiveAdmin::Generators::InstallGenerator
  def create_migrations
    # do nothing
  end
end
