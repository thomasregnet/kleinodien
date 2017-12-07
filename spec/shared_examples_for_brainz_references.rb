RSpec.shared_examples 'a MusicBrainz reference' do
  context 'compared with a clone' do
    let(:clone) { reference }

    it 'is eql' do
      expect(reference).to eql(clone)
    end
  end

  context 'with an object of a different class' do
    let(:clone) { Date.new }
    it 'not eql' do
      expect(reference).not_to eql(clone)
    end
  end

  context 'with a different code' do
    let(:clone) do
      described_class.new(code: 'ea6cef9a-5f18-4648-a68f-9d7c2d954452')
    end

    it 'not eql' do
      expect(reference).not_to eql(clone)
    end
  end

  context 'with a different host' do
    let(:clone) do
      described_class.new(
        code: reference.code,
        host: 'bad.host.org'
      )
    end

    it 'is not eql' do
      expect(reference).not_to eql(clone)
    end
  end

  context 'with a different kind' do
    let(:clone) do
      described_class.new(
        code: reference.code,
        kind: 'bad kind'
      )
    end

    it 'is not eql' do
      expect(reference).not_to eql(clone)
    end
  end

  context 'with a different path_prefix' do
    let(:clone) do
      described_class.new(
        code:        reference.code,
        path_prefix: 'bad/path_prefix'
      )
    end

    it 'is not eql' do
      expect(reference).not_to eql(clone)
    end
  end

  context 'with a different query_string' do
    let(:clone) do
      described_class.new(
        code: reference.code,
        query_string: '?what+is+this'
      )
    end

    it 'is not eql' do
      expect(reference).not_to eql(clone)
    end
  end

  context 'with a different schema' do
    let(:clone) do
      described_class.new(
        code: reference.code,
        schema: 'ptth'
      )
    end

    it 'is not eql' do
      expect(reference).not_to eql(clone)
    end
  end
end
