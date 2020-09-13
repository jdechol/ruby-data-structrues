RSpec.describe Jared::HashMap do
  describe '#put' do
    subject { described_class.new }

    before do
      10.times do |index|
        subject.put(index, index.to_s)
      end
    end

    it 'can update existing values in the hashmap' do
      subject.put(1, 'one')
      subject.put(5, 'five')
      expect(subject.get(1)).to eq 'one'
      expect(subject.get(5)).to eq 'five'
    end
  end
end
