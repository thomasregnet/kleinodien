RSpec.shared_examples 'a model with an IncompleteDate' do
  let(:date_getter) { date_naming }
  let(:date_setter) { date_naming + '=' }

  it 'works with a Fixnum as IncompleteDate' do
    candidate.send(date_setter, IncompleteDate.from_string('2015'))
    expect(candidate.send(date_getter).to_s).to eq '2015-01-01'
    expect(candidate.send(date_getter).mask).to eq(4)
    expect(candidate.save).to be true
  end

  it 'works with a String representing only year and month' do
    candidate.send(date_setter, IncompleteDate.from_string('2015-03'))
    expect(candidate.send(date_getter).to_s).to eq('2015-03-01')
    expect(candidate.send(date_getter).mask).to eq(6)
    expect(candidate.save).to be true
  end

  it 'works with a String representing a iso-date' do
    candidate.send(date_setter, IncompleteDate.from_string('2015-03-13'))
    expect(candidate.send(date_getter).to_s).to eq('2015-03-13')
    expect(candidate.send(date_getter).mask).to eq(7)
    expect(candidate.save).to be true
  end
end
