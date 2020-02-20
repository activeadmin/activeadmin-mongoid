require 'spec_helper'

describe ActiveAdmin::Filters::FormBuilder do
  describe '#default_input_type' do
    let(:instance) { described_class.new({}, {}, {}, {}) }
    let(:column) { double(:column) }
    subject { instance.default_input_type(nil) }

    before do
      allow(column).to receive_message_chain('type.name.downcase.to_sym')
        .and_return(column_symbol)
      allow(instance).to receive(:column_for).with(anything).and_return(column)
    end

    context 'date_range' do
      %i(date datetime time).each do |meth|
        let(:column_symbol) { meth }
        it { is_expected.to eq :date_range }
      end
    end

    context 'string' do
      %i(string text object).each do |meth|
        let(:column_symbol) { meth }
        it { is_expected.to eq :string }
      end
    end

    context 'numeric' do
      %i(float decimal).each do |meth|
        let(:column_symbol) { meth }
        it { is_expected.to eq :numeric }
      end
    end

    context 'integer' do
      let(:column_symbol) { :integer }
      context 'select' do
        before { allow(instance).to receive(:reflection_for).and_return(true) }
        it { is_expected.to eq :select }
      end

      context 'numeric' do
        before { allow(instance).to receive(:reflection_for).and_return(false) }
        it { is_expected.to eq :numeric }
      end
    end

    context 'association' do
      before { allow(instance).to receive(:column_for).and_return(nil) }
      before { allow(instance).to receive(:is_association?).and_return(true) }
      let(:column_symbol) { :foobar }
      it { is_expected.to eq :select }
    end

    context 'unknown' do
      before { allow(instance).to receive(:column_for).and_return(nil) }
      before { allow(instance).to receive(:is_association?).and_return(false) }
      let(:column_symbol) { :bizbaz }
      it { is_expected.to eq :string }
    end

    # when :date, :datetime, :time;   :date_range
    # when :string, :text, :object;  :string
    # when :float, :decimal;          :numeric
    # when :integer
  end
end
