
supervisor-python-pip:
  pkg.installed:
    - name: python-pip

supervisor:
  pip.installed:
    - require:
      - pkg: supervisor-python-pip

  service.running:
    - enable: True
    - reload: True
    - require:
      - file: supervisor-init-script
      - file: supervisor-config-file
      - file: supervisor-conf-dir
      - file: supervisor-default-file
      - file: supervisor-log-dir

supervisor-init-script:
  file.managed:
    - name: /etc/init.d/supervisor
    - source: salt://supervisor/files/supervisor.init
    - user: root
    - group: root
    - mode: 775
    - require: 
      - pip: supervisor

supervisor-config-file:
  file.managed:
    - name: /etc/supervisord.conf
    - source: salt://supervisor/files/supervisord.conf
    - user: root
    - group: root
    - mode: 775
    - require: 
      - pip: supervisor

supervisor-default-file:
  file.managed:
    - name: /etc/default/supervisor
    - source: salt://supervisor/files/supervisor.default
    - user: root
    - group: root
    - mode: 644
    - require: 
      - file: supervisor-config-file

supervisor-conf-dir:
  file.directory:
    - name: /etc/supervisor/conf.d
    - user: root
    - group: root
    - mode: 775
    - makedirs: True

supervisor-log-dir:
  file.directory:
    - name: /var/log/supervisor
    - user: root
    - group: root
    - mode: 775
    - makedirs: True
