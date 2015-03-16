require 'spec_helper'

describe Puppet::Type.type(:swap_file).provider(:linux) do

  let(:resource) { Puppet::Type.type(:swap_file).new({
    :name     => '/tmp/swap',
    :size     => '1024',
  })}

  let(:provider) { resource.provider }

end
