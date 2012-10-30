require 'spec_helper'
require 'active_admin/mongoid/document'

describe ActiveAdmin::Mongoid::Document do
  # let(:resource_class) { Class.new.tap { include Mongoid::Document } }
  describe '.primary_key' do
    it 'responds' do
      Post.primary_key.should eq(:_id)
      # resource_class.human_attribute_name(resource_class.primary_key)
    end
  end
end
