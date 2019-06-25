RSpec.describe Surveyor::Answer do
  subject { described_class.new(question: 'Sample Question?', value: 'Sample Value') }

  it "doesn't raise an error when question and value are valid" do
    expect { described_class.new(question: 'Sample Question', value: 'Sample Value') }.not_to raise_error
  end

  describe 'Question' do
    it 'has a question that you can query with instance.question' do
      expect(subject.question).to eq('Sample Question?')
    end
  end

  describe 'Answer' do
    sample_question = Surveyor::Question.new(title: 'Sample Question')

    it 'has a value' do
      expect(subject.value).to eq('Sample Value')
    end

    it 'is a valid Answer value when it is a String' do
      expect(subject.value_is_valid?(subject.value)).to eq(true)
    end

    it 'raises Answer value must be a String exception when value is not a String' do
      expect { described_class.new(question: sample_question, value: 1) }.to raise_error(ArgumentError, 'Invalid Answer: Answer value must be a String')
    end

    it "raises 'Answer value cannot be empty' exception when value is an empty String" do
      expect { described_class.new(question: sample_question, value: '') }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
    end

    it "raises 'Answer value cannot be empty' exception when value is nil" do
      expect { described_class.new(question: sample_question, value: nil) }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
    end

    it "raises 'Answer value cannot be empty' exception when valus is whitespace" do
      expect { described_class.new(question: sample_question, value: "             ") }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
    end
  end
end
