RSpec.describe Surveyor::Question do
  subject { described_class.new(title: 'Sample Title') }

  it "doesn't raise an error when Title is valid" do
    expect { described_class.new(title: 'Sample Title') }.not_to raise_error
    # ! don't know how to avoid repeated code here
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
      expect { described_class.new(title: 1) }.to raise_error(ArgumentError, 'Invalid Question: Title value must be a String')
    end

    it "raises 'Question cannot be empty' exception if question is an empty String" do
      expect { described_class.new(title: "") }.to raise_error(ArgumentError, 'Invalid Question: Title value cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is nil" do
      expect { described_class.new(title: nil) }.to raise_error(ArgumentError, 'Invalid Question: Title value cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is whitespace" do
      expect { described_class.new(title: "          ") }.to raise_error(ArgumentError, 'Invalid Question: Title value cannot be empty')
    end

    it "raises 'Question must be more than three characters long' exception" do
      expect { described_class.new(title: "a") }.to raise_error(ArgumentError, 'Invalid Question: Title value must be more than three characters long')
    end
  end
end
