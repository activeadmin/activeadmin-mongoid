Mongoid::Criteria.class_eval do
  def relation *args, &block
    self
  end

  def base
    klass
  end
end

