require 'serverspec'

# Required by serverspec
set :backend, :exec

case os[:family]
when 'debian','ubuntu'
  package_name = 'redis-server'
  service_name = 'redis-server'
  config_file = '/etc/redis/redis.conf'
when 'redhat','centos'
  package_name = 'redis'
  service_name = 'redis'
  config_file = '/etc/redis.conf'
else
  package_name = 'redis'
  service_name = 'redis'
  config_file = '/etc/redis.conf'
end

describe package(package_name) do
  it { should be_installed }
end

describe service(service_name) do
  it { should be_running }
  it { should be_enabled }
end

describe file(config_file) do
  it { should exist }
end
