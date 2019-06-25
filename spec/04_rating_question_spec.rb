RSpec.describe Surveyor::RatingQuestion do
  subject { described_class.new(title: 'Sample Title') }

  it 'has a title' do
    expect(subject.title).to eq('Sample Title')
  end
end
