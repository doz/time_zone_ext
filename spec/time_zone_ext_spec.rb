require 'spec_helper'

describe TimeZoneExt do
  before(:each) do
    Time.zone = 'EST'
  end

  it "parses time with timezone specified by name" do
    Time.zone.strptime("2012-06-02 00:00 UTC", "%Y-%m-%d %H:%M %Z").to_s.should == "2012-06-01 19:00:00 -0500"
  end

  it "parses time with timezone specified by offset" do
    Time.zone.strptime("2012-06-02 00:00 +0100", "%Y-%m-%d %H:%M %z").to_s.should == "2012-06-01 18:00:00 -0500"
  end

  describe 'time without explicit timezone' do
    before do
      # For daylight dependent times, we need to set
      # zone as Eastern Time, EST will always give -0500
      Time.zone = 'Eastern Time (US & Canada)'
    end

    context 'when time is in daylight saving period' do
      let(:dst_time_string) { '2012-06-02 00:00' }
      it "parses time in Time.zone with daylight saving time" do
        dst_time = Time.zone.strptime(dst_time_string, "%Y-%m-%d %H:%M")
        expect(dst_time.to_s).to eq("2012-06-02 00:00:00 -0400")
      end
    end

    context 'when time is not in daylight saving period' do
      let(:non_dst_time_string) { '2012-12-02 00:00' }
      it 'parses time in Time.zone without daylight saving time' do
        non_dst_time = Time.zone.strptime(non_dst_time_string, "%Y-%m-%d %H:%M")
        expect(non_dst_time.to_s).to eq("2012-12-02 00:00:00 -0500")
      end
    end
  end

  it "parses time with named time zone" do
    Time.zone = "Moscow"
    Time.zone.strptime("2012-06-02 00:00", "%Y-%m-%d %H:%M").to_s.should == "2012-06-02 00:00:00 +0400"
  end
end
