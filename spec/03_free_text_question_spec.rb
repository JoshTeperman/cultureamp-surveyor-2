RSpec.describe Surveyor::FreeTextQuestion do
  subject { described_class.new(title: 'Hello World') }

  it 'has a title' do
    expect(subject.title).to eq('Hello World')
  end

  context('valid answer?') do
    it 'is valid when it is a String' do
      expect(subject.valid_answer?('Test String')).to eq(true)
    end

    it 'is invalid when it is not a String' do
      expect(subject.valid_answer?(1)).to eq(false)
    end
  end
end