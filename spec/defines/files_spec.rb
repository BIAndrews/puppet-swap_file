require 'spec_helper'

describe 'swap_file::files' do
  let(:title) { 'default' }

  let(:facts) do
    {
      :operatingsystem => 'RedHat',
      :osfamily        => 'RedHat',
      :operatingsystemrelease => '7',
      :concat_basedir => '/tmp',
      :memorysize => '1.00 GB'
    }
  end

  # Add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)

  context 'default parameters' do
    it do
      is_expected.to compile.with_all_deps
    end
    it do
      is_expected.to contain_swap_file__files('default')
    end
    it do
      is_expected.to contain_swap_file('/mnt/swap.1')
    end
    it do
      is_expected.to contain_exec('Create swap file /mnt/swap.1').
               with({"command"=>"/bin/dd if=/dev/zero of=/mnt/swap.1 bs=1M count=1073",
                     "creates"=>"/mnt/swap.1"})
    end
    it do
      is_expected.to contain_file('/mnt/swap.1').
               with({"owner"=>"root",
                     "group"=>"root",
                     "mode"=>"0600",
                     "require"=>"Exec[Create swap file /mnt/swap.1]"})
    end
    it do
      is_expected.to contain_mount('/mnt/swap.1').
               with({"require"=>"Swap_file[/mnt/swap.1]"})
    end
  end

  context 'custom swapfilesize parameter' do
    let(:params) do
      {
        :swapfilesize => '4.1 GB',
      }
    end
    it do
      is_expected.to compile.with_all_deps
    end
    it do
      is_expected.to contain_exec('Create swap file /mnt/swap.1').
      with({"command"=>"/bin/dd if=/dev/zero of=/mnt/swap.1 bs=1M count=4402",
       "creates"=>"/mnt/swap.1"})
    end
  end

  context 'ensure=>absent' do
    let(:params) do
      {
        :ensure => 'absent',
      }
    end
    it do
      is_expected.to compile.with_all_deps
    end
    it do
      is_expected.to contain_file('/mnt/swap.1').
               with({"ensure"=>"absent",})
    end
    it do
      is_expected.to contain_mount('/mnt/swap.1').
               with({"ensure"=>"absent"})
    end
  end

end
