RSpec.describe Surveyor::Response do
  subject { described_class.new(email: 'joshteperman@gmail.com') }

  it 'has an email address of the user who submitted the response' do
    expect(subject.email).to eq('joshteperman@gmail.com')
  end

  it "includes answers to the survey's questions" do
    answer = double(:answer)
    subject.add_answer(answer)

    expect(subject.answers).to include(answer)
  end

end


# And now we get to a harder part of the coding test where there are no pre-written tests to guide you. It is up to you now to write tests and the code that goes along with them in order to continue.
# From this point on, it is assumed that you will be writing tests and code for each part as you go.
# Your task is to now add responses to this application. Responses are included on a survey as a way of tracking a particular person's response to a survey. A response will include a particular person's answers to the survey's questions. To represent that data, you should add a Response class which will be used to represent a survey's responses.
# Add a Response class to the application. Responses should have an email attribute that tracks the email address of the user who has submitted the response.
# You should be able to add responses to a survey, and also ask a survey what its responses are.