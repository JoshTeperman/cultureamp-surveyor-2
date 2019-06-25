RSpec.describe Surveyor::Answer do
  context 'Free Text Question' do
    sample_question = Surveyor::FreeTextQuestion.new(title: 'Sample Question')
    subject { described_class.new(question: sample_question, value: 'Sample Value') }

    it "doesn't raise an error when question and value are valid" do
      expect { described_class.new(question: sample_question, value: 'Sample Value') }.not_to raise_error
    end

    describe 'Question' do
      it 'has a question that you can query with instance.question' do
        expect(subject.question).to eq(sample_question)
      end
    end

    describe 'Answer Validation' do
      it 'has a value' do
        expect(subject.value).to eq('Sample Value')
      end

      it 'is a valid Answer value when it is a String' do
        expect(subject.validate_answer(subject.value)).to eq(true)
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

  context 'Rating Question' do
    sample_question = Surveyor::RatingQuestion.new(title: 'Sample Question')
    subject { described_class.new(question: sample_question, value: 1) }

    it "doesn't raise an error when question and value are valid" do
      expect { described_class.new(question: sample_question, value: 1) }.not_to raise_error
    end

    describe 'Question' do
      it 'has a question that you can query with instance.question' do
        expect(subject.question).to eq(sample_question)
      end
    end

    describe 'Answer Validation' do
      it 'has a value' do
        expect(subject.value).to eq('Sample Value')
      end

      it 'is a valid answer' do
        # ! I propose to replace this test and method with the error handling below:
        expect(subject.value_is_valid?(subject.value)).to eq(true)
      end

      it 'is a valid Answer value when it is an Integer 1' do
        # let(:value) { 1 }
        # expect(subject.question.value_is_valid?(:value)).to eq(true)
        # expect() that value_is_valid? for subject.question will return true
      end

      it 'is a valid Answer value when it is an Integer 2' do
        expect(subject.value_is_valid?(subject.value)).to eq(true)
      end

      it 'is a valid Answer value when it is an Integer 3' do
        expect(subject.value_is_valid?(subject.value)).to eq(true)
      end

      it 'is a valid Answer value when it is an Integer 4' do
        expect(subject.value_is_valid?(subject.value)).to eq(true)
      end

      it 'is a valid Answer value when it is an Integer 5' do
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
end
