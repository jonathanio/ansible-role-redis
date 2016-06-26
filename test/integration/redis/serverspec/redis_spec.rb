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

describe file(config_file) do
  it { should exist }
  it { should be_file }
  it { should be_mode '0640' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'redis' }
  its(:content) { should match /^daemonize yes/ }
  its(:content) { should match /^bind 0.0.0.0/ }
  its(:content) { should match /^port 6379/ }
  its(:content) { should match /^unixsocket \/tmp\/redis.sock/ }
  its(:content) { should_not match /^unixsocketperm/ }
  its(:content) { should match /^timeout 60/ }
  its(:content) { should match /^loglevel info/ }
  its(:content) { should match /^logfile \/var\/log\/redis\/#{service_name}.log/ }
  its(:content) { should match /^syslog-enabled yes/ }
  its(:content) { should match /^syslog-ident redis/ }
  its(:content) { should match /^syslog-facility local0/ }
  its(:content) { should match /^databases 32/ }
  its(:content) { should match /^dir \/var\/lib\/redis/ }
  its(:content) { should match /^dbfilename dump.rdb/ }
  its(:content) { should match /^rdbcompression yes/ }
  its(:content) { should match /^rdbchecksum yes/ }
  its(:content) { should match /^save 900 1/ }
  its(:content) { should match /^save 300 10/ }
  its(:content) { should match /^save 60 10000/ }
  its(:content) { should match /^maxclients 16/ }
  its(:content) { should match /^maxmemory 64mb/ }
  its(:content) { should match /^maxmemory-policy noeviction/ }
  its(:content) { should match /^maxmemory-samples 5/ }
  its(:content) { should match /^appendonly no/ }
  its(:content) { should_not match /^appendfilename/ }
  its(:content) { should_not match /^appendfsync/ }
  its(:content) { should_not match /^no-appendfsync-on-rewrite/ }
end

describe service(service_name) do
  it { should be_running }
  it { should be_enabled }
end

describe process(service_name) do
  it { should be_running }
end

describe port(6379) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end
