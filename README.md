# ansible-role-redis

[![Galaxy](http://img.shields.io/badge/galaxy-jonathanio.redis-blue.svg?style=flat-square)](https://galaxy.ansible.com/jonathanio/redis)

Ansible role to install and manage Redis, and tested with test-kitchen and serverspec. Built using assistance from [sbaerlocher.redis](https://github.com/sbaerlocher/ansible.redis) and [Stouts.redis](https://github.com/Stouts/Stouts.redis).

## Requirements

None

## Role Variables

The following are the available configuration settings for this role. Full
details on the respective options are available in the
[redis.conf](https://raw.githubusercontent.com/antirez/redis/3.0/redis.conf)
file.

```yaml
redis_daemonize: yes                  # Daemonize the service? Note: On systems
                                      # running systemd, this should be set to
                                      # no (pre-set on ArchLinux)
redis_bind:                           # List of the IP addresses to pass onto
  - 127.0.0.1                         # bind (leave as empty array for all)
redis_port: 6379                      # Port to bind to
redis_tcp_backlog: 511                # [Optional] TCP backlog settings for
                                      # connection performance (see NOTES)
redis_timeout: 0                      # [Optional] Timeout for idle client
                                      # connection (see NOTES)
redis_tcp_keepalive: 60               # Enable SO_KEEPALIVE and set how long the
                                      # interval at which to send ACKs
redis_socket: /run/redis/redis.sock   # [Optional] Path to create Unix Socket
redis_socket_mode: 0755               # [Optional] Permission to give to Socket

redis_log_level: notice               # Notice level for logs
redis_log_file: "/var/log/redis/redis.log"  # Path to logs

redis_syslog: no                      # Send logs via syslog?
redis_syslog_ident: redis             # Set the identity to use
redis_syslog_facility: local0         #   and the facility

redis_databases: 16                   # Number of databases
redis_db_dir: /var/lib/redis          # Location of databases
redis_db_filename: dump.rdb           # Database filename
redis_db_compression: yes             # Enable compression?
redis_db_save_times:                  # Array of preconditions for when to save
  - [900, 1]                          # the database to disk (900 seconds if 1
  - [300, 10]                         # or more keys have changed, 300 seconds
  - [60, 10000]                       # for 10 or more, etc.)

redis_max_clients: 128                # Maximum no. of clients that can connect

redis_max_memory: 128mb               # Maximum memory to use
redis_max_memory_policy: volatile-lru # Eviction policy to use on data in memory
redis_max_memory_samples: 3           # Average number of samples to use

redis_append_only: no                 # Enable append-only mode for data store
redis_append_filename: appendonly.aof # Filename for append-only store
redis_append_fsync: everysec          # When to fsync the data in the store
```

Also:

```yaml
use_firewalld: no                     # If you use firewalld, enable this and
                                      # the appropriate Firewall ports will be
                                      # added and enabled in firewalld
```

### NOTES

Both `redis_tcp_backlog` (i.e. `tcp-backlog`) and `redis_tcp_keepalive` (i.e.
`tcp-keepalive`) options are relativly recent and may not be supported by all
distributions and versions.

## Dependencies

None

## Example Playbook

```yaml
- name: Install Redis
  hosts: redis_servers
  roles:
     - { role: jonathanio.redis, tags: ['redis'] }
```

## License

This project is under the *BSD* License. See the `LICENSE` file for the full license text.

## Author Information

Jonathan Wright <jon@than.io>
