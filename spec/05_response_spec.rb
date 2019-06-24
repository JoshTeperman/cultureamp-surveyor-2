RSpec.describe Surveyor::Response do
  subject { described_class.new(email: 'joshteperman@gmail.com') }

  it 'has an email address of the user who submitted the response' do
    expect(subject.email).to eq('joshteperman@gmail.com')
  end

  # it "includes answers to the survey's questions" do
  #   answer = double(:answer)
  #   subject.add_answer(answer)

  #   expect(subject.answers).to include(answer)
  # end

end

# should I make assumptions about what a response contains and test for that?