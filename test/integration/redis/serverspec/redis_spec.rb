require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('redis-server'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
  it { should be_installed }
end

describe package('redis'), :if => ['redhat', 'centos'].include?(os[:family]) do
  it { should be_installed }
end
