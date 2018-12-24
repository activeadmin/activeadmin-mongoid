require 'delegate'

Mongoid::Criteria.class_eval do
  def relation(*_args)
    self
  end

  def base
    klass
  end

  def table
    CollectionTable.new(klass.collection)
  end

  class CollectionTable < SimpleDelegator
    def from(*_a)
      self
    end
  end
end
