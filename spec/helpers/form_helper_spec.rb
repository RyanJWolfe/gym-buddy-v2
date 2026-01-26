require 'rails_helper'

RSpec.describe FormHelper, type: :helper do
  describe '#form_field_error' do
    let(:resource) { double('Resource') }
    let(:field) { :name }

    context 'when there are no errors on the field' do
      before do
        allow(resource).to receive_message_chain(:errors, :[]).with(field).and_return([])
      end

      it 'returns nil' do
        expect(helper.form_field_error(resource, field)).to be_nil
      end
    end

    context 'when there is a blank error on the field' do
      before do
        allow(resource).to receive_message_chain(:errors, :[]).with(field).and_return(["can't be blank"])
      end

      it 'returns a friendly blank message if provided' do
        result = helper.form_field_error(resource, field, friendly_blank_message: 'Name cannot be empty')
        expect(result).to include('⚠️')
        expect(result).to include('Name cannot be empty')
      end

      it 'returns a default blank message if no friendly message is provided' do
        result = helper.form_field_error(resource, field)
        expect(result).to include('⚠️')
        expect(result).to include('Name is required')
      end
    end

    context 'when there is a different error on the field' do
      before do
        allow(resource).to receive_message_chain(:errors, :[]).with(field).and_return(['is too short'])
      end

      it 'returns the full error message' do
        result = helper.form_field_error(resource, field)
        expect(result).to include('⚠️')
        expect(result).to include('Name is too short')
      end
    end
  end
end
