local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'task',
    u.fmt(
      [[
      - name: {}
        {}:
          {}: {}
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'module'),
        u.i(3, 'param'),
        u.i(4, 'value'),
      }
    )
  ),
  u.s(
    'task-copy',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.copy:
          src: {}
          dest: {}
          mode: '{}'
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'src/path'),
        u.i(3, '/dest/path'),
        u.i(4, '0644'),
      }
    )
  ),
  u.s(
    'task-template',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.template:
          src: {}.j2
          dest: {}
          mode: '{}'
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'template'),
        u.i(3, '/dest/path'),
        u.i(4, '0644'),
      }
    )
  ),
  u.s(
    'task-command',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.command:
          cmd: {}
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'command'),
      }
    )
  ),
  u.s(
    'task-shell',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.shell:
          cmd: {}
          chdir: {}
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'script'),
        u.i(3, '/path'),
      }
    )
  ),
  u.s(
    'task-lineinfile',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.lineinfile:
          path: {}
          regexp: '{}'
          line: '{}'
  ]],
      {
        u.i(1, 'description'),
        u.i(2, '/path/to/file'),
        u.i(3, 'pattern'),
        u.i(4, 'replacement'),
      }
    )
  ),
  u.s(
    'task-package',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.package:
          name: {}
          state: {}
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'package-name'),
        u.c(3, { u.t 'present', u.t 'absent', u.t 'latest' }),
      }
    )
  ),
  u.s(
    'task-service',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.service:
          name: {}
          state: {}
          enabled: {}
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'service-name'),
        u.c(3, { u.t 'started', u.t 'stopped', u.t 'restarted' }),
        u.c(4, { u.t 'true', u.t 'false' }),
      }
    )
  ),
  u.s(
    'task-setfact',
    u.fmt(
      [[
      - name: {}
        ansible.builtin.set_fact:
          {}: {}
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'var_name'),
        u.i(3, 'value'),
      }
    )
  ),
  u.s(
    'task-register',
    u.fmt(
      [[
      - name: {}
        {}:
          {}: {}
        register: {}
        when: {}
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'module'),
        u.i(3, 'param'),
        u.i(4, 'value'),
        u.i(5, 'result'),
        u.i(6, 'condition'),
      }
    )
  ),
  u.s(
    'task-block',
    u.fmt(
      [[
      - block:
          {}
        rescue:
          - name: {}
            {}
        always:
          - name: {}
            {}
  ]],
      {
        u.i(1, '- name: task'),
        u.i(2, 'handle error'),
        u.i(3, ''),
        u.i(4, 'cleanup'),
        u.i(5, ''),
      }
    )
  ),
  u.s(
    'task-loop',
    u.fmt(
      [[
      - name: {}
        {}:
          {}: "{{{{ item }}}}"
        loop: "{{{{ {} }}}}"
  ]],
      {
        u.i(1, 'description'),
        u.i(2, 'module'),
        u.i(3, 'param'),
        u.i(4, 'list_var'),
      }
    )
  ),
  u.s(
    'task-loop-dict',
    u.fmt('loop: "{{{{ {} | dict2items }}}}"', {
      u.i(1, 'dict_var'),
    })
  ),
}
