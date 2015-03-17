require 'spec_helper'

describe Puppet::Type.type(:swap_file).provider(:linux) do

  let(:resource) { Puppet::Type.type(:swap_file).new(
    {
    :name     => '/tmp/swap',
    :size     => '1024',
    :provider => described_class.name
    }
  )}

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  swapon_s_output = <<-EOS
# swapon -s
Filename                        Type            Size    Used    Priority
/dev/sda2                       partition       4192956 0       -1
/dev/sda1                       partition       4454542 0       -2
  EOS

  before :each do
    Facter.stubs(:value).with(:kernel).returns('Linux')
    provider.class.stubs(:swapon).with(['-s']).returns(swapon_s_output)
  end

  describe 'self.prefetch' do
    it 'exists' do
      provider.class.instances
      provider.class.prefetch({})
    end
  end

  describe 'exists?' do
    it 'checks if swap file exists' do
      expect(instance.exists?).to be_truthy
    end
  end

  describe 'self.instances' do
    it 'returns an array of swapfiles' do
      swapfiles      = provider.class.instances.collect {|x| x.name }
      swapfile_sizes = provider.class.instances.collect {|x| x.size }

      expect(swapfiles).to      include('/dev/sda1','/dev/sda2')
      expect(swapfile_sizes).to include('4192956','4454542')
    end
  end

end
