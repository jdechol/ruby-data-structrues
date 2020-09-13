require './src/linked_list/linked_list'
require "ostruct"

RSpec.describe LinkedList do
  let(:cherries) { OpenStruct.new(key: 1, value: 'cherry') }
  let(:apples) { OpenStruct.new(key: 2, value: 'apples') }

  before do
    subject.add_last(cherries)
    subject.add_last(apples)
  end

  subject { described_class.new }

  describe '#add_first' do
    let(:oranges) { OpenStruct.new(key: 'basket', value: 'oranges') }
    before do
      expect(subject.index_of { |data| data.key == 1 }).to eq 0
    end

    it 'adds to the start of the list' do
      subject.add_first(oranges)
      expect(subject.index_of { |data| data.key == 'basket' }).to eq 0
      expect(subject.index_of { |data| data.key == 1 }).to eq 1
    end
  end

  describe '#find_element' do
    it 'can find values with a block' do
      expect(subject.find_element { |data| data.key == 1 }).to eq(cherries)
      expect(subject.find_element { |data| data.key == 2 }).to eq(apples)
      expect { subject.find_element { |data| data.key == 4 } }
        .to raise_exception(StandardError)
    end
  end

  describe '#get_first' do
    it 'returns the first value in the list' do
      expect(subject.get_first).to eq cherries
    end

    context 'when the list is empty' do
      before do
        subject.clear
      end

      it 'returns nil' do
        expect(subject.get_first).to eq nil
      end
    end
  end

  describe '#index_of' do
    context 'when an item is found' do
      it 'returns the index' do
        expect(subject.index_of { |data| data.key == 1 }).to eq 0
        expect(subject.index_of { |data| data.key == 2 }).to eq 1
      end
    end

    context 'when an item is not found' do
      it 'returns -1' do
        expect(subject.index_of { |data| data.key == 12_345 }).to eq -1
      end
    end
  end

  describe '#remove' do
    before do
      expect(subject.length).to eq 2
      expect(subject.contains? { |data| data.value == 'cherry' }).to be_truthy
    end

    it 'removes the data requested by the predicate' do
      subject.remove { |data| data.key == 1 }
      expect(subject.length).to eq 1
      expect(subject.contains? { |data| data.value == 'cherry' }).to be_falsey
    end

    context 'when the data is not in the list' do
      it 'throws a helpful error message' do
        expect { subject.remove { |data| data.key == 'not a key' } }
          .to raise_exception(StandardError)
      end
    end
  end

  describe '#remove_at' do
    context 'when the index is in range' do
      it 'removes the data at the requested index' do
        subject.remove_at(1)
        expect(subject.length).to eq 1
        expect(subject.find_by(cherries)).to eq cherries
        expect { subject.find_by(apples) }.to raise_exception StandardError
      end
    end

    context 'when the index is not in range' do
      it 'raises an error' do
        expect { subject.remove_at(2) }.to raise_exception StandardError
      end
    end
  end
end
