RSpec.describe Surveyor::RatingQuestion do
  subject { described_class.new(title: 'Sample Title', value: 'Sample Value') }

  it 'has a title' do
    expect(subject.title).to eq('Sample Title')
  end

  describe 'Answer Validation' do
    it "true when 1" do
      expect(subject.validate_answer(1)).to eq(true)
    end

    it "true when 2" do
      expect(subject.validate_answer(2)).to eq(true)
    end

    it "true when 3" do
      expect(subject.validate_answer(3)).to eq(true)
    end

    it "true when 4" do
      expect(subject.validate_answer(4)).to eq(true)
    end

    it "true when 5" do
      expect(subject.validate_answer(5)).to eq(true)
    end

    it "false when 6" do
      expect(subject.validate_answer(6)).to eq(false)
    end

    it "false when -1" do
      expect(subject.validate_answer(-1)).to eq(false)
    end
  end
end
