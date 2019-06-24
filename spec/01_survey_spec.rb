RSpec.describe Surveyor::Survey do
  subject { described_class.new(name: 'Engagement Survey') }

  it "has a name" do
    expect(subject.name).to eq("Engagement Survey")
  end

  it "can have questions added" do
    question = double(:question)
    subject.add_question(question)
    expect(subject.questions).to include(question)
  end

  it "can have responses added" do
    response = double(:response)
    subject.add_response(response)
    expect(subject.responses).to include(response)
  end

  it 'can ask a survey what its responses are' do
    response = double(:response) # should I refactor? > same code as prev block
    subject.responses.push(response)
    expect(subject.responses).to include(response)
  end
end
