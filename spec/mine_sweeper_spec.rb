RSpec.describe MineSweeper do
  describe "grid transform" do
    let(:matrix) { <<~MATRIX }
      4 4
      *...
      ....
      .*..
      ....
      3 5
      **...
      .....
      .*...
      0 0
    MATRIX

    let(:expected) { <<~RESULT }
      Field #1:
      *100
      2210
      1*10
      1110

      Field #2:
      **100
      33200
      1*100
    RESULT

    subject { described_class.transform(matrix) }

    it { is_expected.to eq(expected) }
  end
end
