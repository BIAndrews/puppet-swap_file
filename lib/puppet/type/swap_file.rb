Puppet::Type.newtype(:swap_file) do

  ensurable

  desc <<-DOC
  Used to configure swap files
  === Examples

  swap_file { '/mnt/swap.1':
    ensure   => 'present',
    size     => '1068028',
  }
  DOC

  newparam(:file, :namevar => true) do
    desc "The file path of the swapfile."
  end

  newproperty(:type) do
    desc "The type of the swapfile"
  end

  newproperty(:size) do
    desc "The size of the swapfile in bytes"
  end

  newproperty(:used) do
    desc "The amount of space used" 
  end

  newproperty(:priority) do
    desc "The priority of the swapfile" 
  end

end