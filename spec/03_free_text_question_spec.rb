RSpec.describe Surveyor::FreeTextQuestion do
  subject { described_class.new(title: 'Sample Title', value: 'Sample Value') }

  it 'has a title' do
    expect(subject.title).to eq('Sample Title')
  end

  describe 'Answer Validation' do
    it 'is valid when it is a String' do
      expect(subject.validate_answer('Test String')).to eq(true)
    end
  end

end
