# frozen_string_literal: true

RSpec.shared_examples 'a model with an IncompleteDate' do
  let(:date_getter) { date_naming }
  let(:date_setter) { date_naming + '=' }

  describe '.from_string' do
    context 'with "2015" as parameter' do
      before do
        candidate.send(date_setter, IncompleteDate.from_string('2015'))
      end

      it 'returns "2015" as date' do
        expect(candidate.send(date_getter).to_s).to eq '2015'
      end

      it 'returns 4 for the mask' do
        expect(candidate.send(date_getter).mask).to eq(4)
      end

      it 'can be persisted' do
        expect(candidate.save).to be true
      end
    end

    context 'with "2015-03" as parameter' do
      before do
        candidate.send(date_setter, IncompleteDate.from_string('2015-03'))
      end

      it 'returns "2015-03" as date' do
        expect(candidate.send(date_getter).to_s).to eq '2015-03'
      end

      it 'returns 6 for the mask' do
        expect(candidate.send(date_getter).mask).to eq(6)
      end

      it 'can be persisted' do
        expect(candidate.save).to be true
      end
    end

    context 'with "2015-03-02" as parameter' do
      before do
        candidate.send(date_setter, IncompleteDate.from_string('2015-03-02'))
      end

      it 'returns "2015-03" as date' do
        expect(candidate.send(date_getter).to_s).to eq '2015-03-02'
      end

      it 'returns 6 for the mask' do
        expect(candidate.send(date_getter).mask).to eq(7)
      end

      it 'can be persisted' do
        expect(candidate.save).to be true
      end
    end
  end
end
