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

  it "parses time without explicitly specified timezone" do
    Time.zone.strptime("2012-06-02 00:00", "%Y-%m-%d %H:%M").to_s.should == "2012-06-02 00:00:00 -0500"
  end

  describe "Central Time (US & Canada)" do
    before(:each) do
      Time.zone = 'Central Time (US & Canada)'
    end

    describe "Daylight Savings Time" do
      it { expect(Time.zone.now.strftime('%:z')).to eq('-05:00') }
      it { expect(Time.zone.strptime("2014-07-20 12:00", "%Y-%m-%d %H:%M").to_s).to eq('2014-07-20 12:00:00 -0500') }
    end

    describe "Regular Time" do
      before do
        Timecop.freeze(Time.local(2014,1,15,12,0))
      end
      it { expect(Time.zone.now.strftime('%:z')).to eq('-06:00') }
      it { expect(Time.zone.strptime("2014-01-20 12:00", "%Y-%m-%d %H:%M").to_s).to eq('2014-01-20 12:00:00 -0600') }
    end
  end
end
