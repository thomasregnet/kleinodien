class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_service_class
    template 'service.rb.erb', "app/services/#{file_name}_service.rb"
  end

  def create_service_spec
    template 'service_spec.rb.erb', "spec/services/#{file_name}_service_spec.rb"
  end
end
