RSpec.describe Surveyor::Question do
  subject { described_class.new(title: 'Sample Title', value: 'Sample Value') }

  it "doesn't raise an error when title and value are valid" do
    expect { described_class.new(title: 'Sample Title', value: 'Sample Value') }.not_to raise_error
  end

  describe 'Title' do
    it 'has a title that you can query with instance.title' do
      expect(subject.title).to eq('Sample Title')
    end

    it 'is a valid title when the title is a String' do
      expect(subject.title_is_valid?(subject.title)).to eq(true)
    end
  end

  describe 'Question' do
    it "raises 'Question must be a String' exception if question is a number" do
      expect { described_class.new(value: 1) }.to raise_error(ArgumentError, 'Invalid Question: Question value must be a String')
    end

    it "raises 'Question cannot be empty' exception if question is an empty String" do
      expect { described_class.new(value: "") }.to raise_error(ArgumentError, 'Invalid Question: Question value cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is nil" do
      expect { described_class.new(value: nil) }.to raise_error(ArgumentError, 'Invalid Question: Question value cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is whitespace" do
      expect { described_class.new(value: "          ") }.to raise_error(ArgumentError, 'Invalid Question: Question value cannot be empty')
    end

    it "raises 'Question must be more than three characters long' exception" do
      expect { described_class.new(value: "a") }.to raise_error(ArgumentError, 'Invalid Question: Question value must be more than three characters long')
    end
  end
end
