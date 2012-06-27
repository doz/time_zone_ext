require 'spec_helper'

describe TimezoneExt do
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
end
