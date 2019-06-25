RSpec.describe Surveyor::Response do
  subject { described_class.new(email: 'joshteperman@gmail.com') }

  it 'has an email address of the user who submitted the response' do
    expect(subject.email).to eq('joshteperman@gmail.com')
  end

  describe 'Survey Answers' do
    it 'has an array of answers that you can query with instance.answers' do
      expect(subject.answers). to eq([])
    end

    it 'can add answers' do
      new_answer = Surveyor::Answer.new(question: 'Sample question', value: 'Sample Answer')
      subject.add_answer(new_answer)
      expect(subject.answers).to include(new_answer)
    end
  end
end

# ! assumption: email validation happens during sign-up, therefore not testing for valid email address
