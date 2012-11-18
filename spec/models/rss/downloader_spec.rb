require 'spec_helper'

describe Rss::Downloader do
  describe '#download!' do
    let(:xml) { File.read("#{Rails.root}/spec/fixtures/rss_feed.xml") }
    let(:url) { 'http://www.example.com/feed.xml' }

    subject { described_class.new(url).download! }

    it 'downloads a file correctly' do
      stub_request(:any, url).to_return(:body => xml, :status => 200)
      subject.should eq(xml)
    end

    it 'raises exception if request fails' do
      stub_request(:any, url).to_return(:status => 404)
      expect { subject }.to raise_exception
    end
  end
end
