RSpec.describe Surveyor::Question do
  subject { described_class.new(title: 'Test Title') }

  it 'has the title \'Test Title\'' do
    expect(subject.title).to eq('Test Title')
  end
end
