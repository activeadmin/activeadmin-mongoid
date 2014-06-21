require 'spec_helper'

describe ActiveAdmin::OrderClause do
  subject { described_class.new clause }

  let(:application) { ActiveAdmin::Application.new }
  let(:namespace)   { ActiveAdmin::Namespace.new application, :admin }

  describe 'sale.price_asc (embedded document)' do
    let(:clause) { 'sale.price_asc' }

    it { should be_valid }
    its(:field) { should == 'sale.price' }
    its(:order) { should == 'asc' }

    specify '#to_sql joins field and order' do
      expect(subject.to_sql).to eq 'sale.price asc'
    end
  end

  describe 'virtual_column_desc' do
    let(:clause) { 'virtual_column_desc' }

    it { should be_valid }
    its(:field) { should == 'virtual_column' }
    its(:order) { should == 'desc' }

    specify '#to_sql' do
      expect(subject.to_sql).to eq 'virtual_column desc'
    end
  end

  describe '_asc' do
    let(:clause) { '_asc' }

    it { should_not be_valid }
  end

  describe 'nil' do
    let(:clause) { nil }

    it { should_not be_valid }
  end
end
