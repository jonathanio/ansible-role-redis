# ansible-role-redis

[![Galaxy](http://img.shields.io/badge/galaxy-jonathanio.redis-blue.svg?style=flat-square)](https://galaxy.ansible.com/jonathanio/redis)

Ansible role to install and manage Redis, and tested with test-kitchen and serverspec. Built using assistance from [sbaerlocher.redis](https://github.com/sbaerlocher/ansible.redis) and [Stouts.redis](https://github.com/Stouts/Stouts.redis).

## Requirements

None

## Role Variables

None

## Dependencies

None

## Example Playbook

    - hosts: redis_servers
      roles:
         - { role: jonathanio.redis, tags: ['redis'] }

## License

This project is under the *BSD* License. See the `LICENSE` file for the full license text.

## Author Information

Jonathan Wright <jon@than.io>
