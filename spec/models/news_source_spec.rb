require 'spec_helper'

describe NewsSource do
  let(:source) { described_class.new(stub(:name => :a_news_source)) }

  describe '.find' do
    before do
      NewsSource::Storage.stub(:get)
    end

    subject { described_class.find(:some_news_source) }

    it 'fetches data from registry' do
      NewsSource::Storage.should_receive(:get).with(:some_news_source)
      subject
    end

    it 'instantiates new object' do
      subject.should be_a(NewsSource)
    end
  end

  describe '#items' do
    before  { NewsItem.stub(:where) }
    subject { source.items }

    it 'fetches all news items belonging to this source' do
      NewsItem.should_receive(:where).with(:source => :a_news_source.to_s)
      subject
    end
  end

  describe '#import!' do
    before  { source.stub(:importer).and_return(stub) }
    subject { source.import! }

    it 'triggers an import of the source' do
      source.importer.should_receive(:import!)
      subject
    end
  end
end

describe NewsSource::Storage do
  let(:entry) { stub(:name => :another_news_source, :url => stub)}

  describe '.add' do
    subject { described_class.add(entry) }

    it 'adds a news source to the storage' do
      expect { subject }.to change { described_class.list.count }.by(1)
    end
  end

  describe '.get' do
    before  { described_class.add(entry) }
    subject { described_class.get(:another_news_source) }

    it 'fetches a news source by its name' do
      subject.should eq(entry)
    end
  end
end

describe NewsSource::Record do
end
