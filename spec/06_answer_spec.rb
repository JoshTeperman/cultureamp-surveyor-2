RSpec.describe Surveyor::Answer do
  subject { described_class.new(question: question) }

  describe 'Answer has a valid question' do
    let(:question) { 'Sample Question?' }

    it 'has a question' do
      expect(subject.question).to eq('Sample Question?')
    end

    it 'is a valid question when the question is a string' do
      expect(subject.question_is_valid?(subject.question)).to eq(true)
    end

    it "doesn't raise an error" do
      expect { Surveyor::Answer.new(question: 'Sample Question') }.not_to raise_error
      # don't know the syntax to avoid this repeated code > how to check initialization in let() block doesn't ArgumentError
    end
  end

  describe 'Error Handling for invalid question when initializing Answer object' do

    it "raises 'Question must be a String' exception if question is a number" do
      expect { Surveyor::Answer.new(question: 1) }.to raise_error(ArgumentError, 'Invalid Question: Question must be a String')
    end

    it "raises 'Question cannot be empty' exception if question is an empty string" do
      expect { Surveyor::Answer.new(question: "") }.to raise_error(ArgumentError, 'Invalid Question: Question cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is nil" do
      expect { Surveyor::Answer.new(question: nil) }.to raise_error(ArgumentError, 'Invalid Question: Question cannot be empty')
    end

    it "raises 'Question cannot be empty' exception if question is whitespace" do
      expect { Surveyor::Answer.new(question: "          ") }.to raise_error(ArgumentError, 'Invalid Question: Question cannot be empty')
    end

    it "raises 'Question must be more than three characters long' exception" do
      expect { Surveyor::Answer.new(question: "a") }.to raise_error(ArgumentError, 'Invalid Question: Question must be more than three characters long')
    end
  end

  describe 'value attribute' do
    let(:value) { 'Sample Answer' }

    it 'has a value attribute' do
      expect(subject.value).to eq('Sample Answer')
    end
  end
end

# TODO may be appropriate to move this error handling to Question Object

# Adding answers

# Now that this application has responses, the next task is to add answers. Answers are included on a response to track what a particular person's answers were to questions on a survey.
# Add an Answer class to the application. Answers should have a question attribute. You should be able to ask an answer what its question is.

# It should not be possible to create an answer without specifying a question.

# An answer should have a value attribute that represents the answer for the question.
# It is not necessary to link an answer to a survey. Instead, answers should be added to responses. You should be able to ask a response what its answers are.

# Finding a particular user's response
# Add a new method that lets you find a survey's response by the user's email address. If the response is not found, then this method should return nil.
# Add another method that returns true or false depending on if the user has responded to this survey yet.