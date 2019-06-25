RSpec.describe Surveyor::Answer do
  subject { described_class.new(question: 'Sample Question?', value: 'Sample Value') }

  describe 'Answer has a valid question' do

    it 'has a question that you can query with instance.question' do
      expect(subject.question).to eq('Sample Question?')
    end

    it 'is a valid question when the question is a string' do
      expect(subject.question_is_valid?(subject.question)).to eq(true)
    end

    it "doesn't raise an error when Question and Value are valid" do
      expect { described_class.new(question: 'Sample Question', value: 'Sample Value') }.not_to raise_error
      # don't know the syntax to avoid this repeated code > how to check initialization in let() block doesn't ArgumentError
    end
  end

  describe 'Error Handling for invalid question when initializing Answer object' do

    it "raises 'Question must be a String' exception if question is a number" do
      expect { described_class.new(question: 1) }.to raise_error(ArgumentError, 'Invalid Question: Question must be a String')
    end

    it "raises 'Question cannot be empty' exception if question is an empty string" do
      expect { described_class.new(question: "") }.to raise_error(ArgumentError, 'Invalid Question: Question cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is nil" do
      expect { described_class.new(question: nil) }.to raise_error(ArgumentError, 'Invalid Question: Question cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is whitespace" do
      expect { described_class.new(question: "          ") }.to raise_error(ArgumentError, 'Invalid Question: Question cannot be empty')
    end

    it "raises 'Question must be more than three characters long' exception" do
      expect { described_class.new(question: "a") }.to raise_error(ArgumentError, 'Invalid Question: Question must be more than three characters long')
    end
  end

  describe 'Answer has a valid value' do

    it 'has a value' do
      expect(subject.value).to eq('Sample Value')
    end

    it 'is a valid value when the value is a String' do
      expect(subject.value_is_valid?(subject.value)).to eq(true)
    end

    it 'raises Answer value must be a String exception when value is not a string' do
      expect { described_class.new(question: 'Sample Question', value: 1) }.to raise_error(ArgumentError, 'Invalid Answer: Answer value must be a String')
    end

    it "raises 'Answer value cannot be empty' exception when value is an empty string" do
      expect { described_class.new(question: 'Sample Question', value: '') }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
    end

    it "raises 'Answer value cannot be empty' exception when value is nil" do
      expect { described_class.new(question: 'Sample Question', value: nil) }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
    end

    it "raises 'Answer value cannot be empty' exception when valus is whitespace" do
      expect { described_class.new(question: 'Sample Question', value: "             ") }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
    end
  end
end

# TODO may be appropriate to move this error handling to Question Object