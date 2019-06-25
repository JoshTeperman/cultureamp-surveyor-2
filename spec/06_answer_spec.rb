RSpec.describe Surveyor::Answer do
  context 'Free Text Question' do
    sample_question = Surveyor::FreeTextQuestion.new(title: 'Sample Question')
    subject { described_class.new(question: sample_question, value: 'Sample Value') }

    it "doesn't raise an error when question and answer value are valid" do
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

      it "raises 'Answer value must be a String' exception when Answer value is not a String" do
        expect { described_class.new(question: sample_question, value: 1) }.to raise_error(ArgumentError, 'Invalid Answer: Answer value must be a String')
      end

      it "raises 'Answer value cannot be empty' exception when Answer value is an empty String" do
        expect { described_class.new(question: sample_question, value: '') }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
      end

      it "raises 'Answer value cannot be empty' exception when Answer value is nil" do
        expect { described_class.new(question: sample_question, value: nil) }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
      end

      it "raises 'Answer value cannot be empty' exception when Answer value is whitespace" do
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
        expect(subject.value).to eq(1)
      end

      it 'Integer 1 is a valid Answer' do
        expect { described_class.new(question: sample_question, value: 1) }.to_not raise_error
      end

      it 'Integer 2 is a valid Answer' do
        expect { described_class.new(question: sample_question, value: 2) }.to_not raise_error
      end

      it 'Integer 3 is a valid Answer' do
        expect { described_class.new(question: sample_question, value: 3) }.to_not raise_error
      end

      it 'Integer 4 is a valid Answer' do
        expect { described_class.new(question: sample_question, value: 4) }.to_not raise_error
      end

      it 'Integer 5 is a valid Answer' do
        expect { described_class.new(question: sample_question, value: 5) }.to_not raise_error
      end

      it "raises 'Outside of Range' exception when Answer value is 0" do
        expect { described_class.new(question: sample_question, value: 0) }.to raise_error(ArgumentError, 'Invalid Answer: Outside of Range')
      end

      it "raises 'Outside of Range' exception when Answer value is 6" do
        expect { described_class.new(question: sample_question, value: 6) }.to raise_error(ArgumentError, 'Invalid Answer: Outside of Range')
      end

      it "raises 'Outside of Range' exception when Answer value is -1" do
        expect { described_class.new(question: sample_question, value: -1) }.to raise_error(ArgumentError, 'Invalid Answer: Outside of Range')
      end

      it "raises 'Answer must be a positive whole number' exception when Answer value is a Float" do
        expect { described_class.new(question: sample_question, value: 1.0) }.to raise_error(ArgumentError, 'Invalid Answer: Answer must be a positive whole number')
      end

      it "raises 'Answer must be a positive whole number' exception when Answer value is a String" do
        expect { described_class.new(question: sample_question, value: "1") }.to raise_error(ArgumentError, 'Invalid Answer: Answer must be a positive whole number')
      end

      it "raises 'Answer value cannot be empty' exception when value is an empty String" do
        expect { described_class.new(question: sample_question, value: '') }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
      end

      it "raises 'Answer value cannot be empty' exception when value is nil" do
        expect { described_class.new(question: sample_question, value: nil) }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
      end

      it "raises 'Answer value cannot be empty' exception when value is whitespace" do
        expect { described_class.new(question: sample_question, value: "             ") }.to raise_error(ArgumentError, 'Invalid Answer: Answer value cannot be empty')
      end
    end
  end
end
