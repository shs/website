require 'spec_helper'

describe Rss::Parser do
  let(:valid_xml)   { File.read("#{Rails.root}/spec/fixtures/rss_feed.xml") }
  let(:invalid_xml) { File.read("#{Rails.root}/spec/fixtures/invalid_rss_feed.xml") }

  describe '#entries' do
    context 'with a valid feed' do
      subject { described_class.new(valid_xml).entries }

      it 'correctly parses xml into an array of entries' do
        subject.should be_an(Array)
      end

      describe 'each entry' do
        subject { described_class.new(valid_xml).entries.first }

        it 'is of correct type' do
          subject.should be_an(Rss::Parser::Entry)
        end

        it 'has a uuid' do
          subject.uuid.should eq('f2ea3ececd238c420e80841d3160c8ac13c835d5')
        end

        it 'has a title' do
          subject.title.should eq('G3:  Version 7 of Unfinished Business for Icewind Dale Now Available')
        end

        it 'has a description' do
          subject.description.should include('Like its predecessors for Baldur\'s Gate and Baldur\'s Gate II, Unfinished Business for Icewind Dale aims to restore content and quests that were omitted from the game as shipped.')
        end

        it 'has a link' do
          subject.link.should eq('http://forums.gibberlings3.net/index.php?showtopic=24874')
        end
      end
    end

    context 'with an invalid feed' do
      it 'raises an exception' do
        expect { described_class.new(invalid_xml).entries }.to raise_exception
      end
    end
  end

  describe '#count' do
    subject { described_class.new(valid_xml).count }

    it 'returns the correct number of entries' do
      subject.should eq(40)
    end
  end
end
