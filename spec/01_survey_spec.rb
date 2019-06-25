RSpec.describe Surveyor::Survey do
  subject { described_class.new(name: 'Engagement Survey') }

  it 'has a name' do
    expect(subject.name).to eq('Engagement Survey')
  end

  it 'can have questions added' do
    question = double(:question)
    subject.add_question(question)
    expect(subject.questions).to include(question)
  end

  describe 'Responses' do
    responses = [
      Surveyor::Response.new(email: 'ohjosh@josh.com'),
      Surveyor::Response.new(email: 'josh@josh.com'),
      Surveyor::Response.new(email: 'wendy@wendy.com'),
    ]
    before(:each) do
      responses.each { |response| subject.add_response(response) }
    end

    it 'can have responses added' do
      response = double(:response)
      subject.add_response(response)
      expect(subject.responses).to include(response)
    end

    it 'can ask a survey what its responses are' do
      expect(subject.responses).to eq(responses)
    end

    describe 'Find User Response' do
      it 'can find responses by user email address' do
        expect(subject.find_user_response('wendy@wendy.com')).to eq(responses[2])
      end
  
      it 'will only return exact email matches' do
        expect(subject.find_user_response('josh@josh.com')).to eq(responses[1])
      end
  
      it "will return nil when a response isn't found" do
        expect(subject.find_user_response('user@user.com')).to eq(nil)
      end
    end

    describe 'User Responded?' do
      it 'will return true if the user has already submitted a response' do
        expect(subject.user_responded?('josh@josh.com')).to eq(true)
      end
  
      it 'will return false if the user has not submitted a response' do
        expect(subject.user_responded?('user@user.com')).to eq(false)
      end
    end
  end
end

# ! assumption: email validation validation is used before filling out the survey to disallow multiple responses from the same user
