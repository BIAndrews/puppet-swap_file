#!/usr/bin/env ruby

require 'spec_helper'

describe Puppet::Type.type(:swap_file) do

  before do
    @class = described_class
    @provider_class = @class.provide(:fake) { mk_resource_methods }
    @provider = @provider_class.new
    @resource = stub 'resource', :resource => nil, :provider => @provider

    @class.stubs(:defaultprovider).returns @provider_class
    @class.any_instance.stubs(:provider).returns @provider
  end

  it "should have :name as its keyattribute" do
    @class.key_attributes.should == [:file]
  end

  describe "when validating attributes" do

    params = [
      :file,
    ] 

    properties = [
      :type,
      :size,
      :used,
      :priority,
    ] 

    params.each do |param|
      it "should have a #{param} parameter" do
        @class.attrtype(param).should == :param
      end
    end

    properties.each do |param|
      it "should have a #{param} property" do
        @class.attrtype(param).should == :property
      end
    end

  end

end