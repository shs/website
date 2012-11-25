require 'spec_helper'

describe Rss::Importer do
  let(:items)  { stub }
  let(:source) { stub }
  let(:entry) do
    Rss::Parser::Entry.new({
      :uuid => 'abc123',
      :title => 'SHS: Khadion released!',
      :description => 'This single achievement will surely result in world peace.',
      :link => 'http://www.google.com',
      :date => Time.now
    })
  end

  subject { described_class.new(stub(:url => stub, :source => source, :items => items)).import! }

  before do
    Rss::Downloader.any_instance.stub(:download!)
    Rss::Parser.any_instance.stub(:entries).and_return([entry])
  end

  it 'creates new records based on feed' do
    items.class.stub(:uuids).and_return([])
    items.should_receive(:create!).with(
      {
        :uuid        => entry.uuid,
        :title       => entry.title,
        :description => entry.description,
        :link        => entry.link,
        :date        => entry.date,
        :source      => source
      }
    )
    subject
  end

  it 'does not duplicate records' do
    items.class.stub(:uuids).and_return(['abc123'])
    items.should_not_receive(:create!)
    subject
  end
end
