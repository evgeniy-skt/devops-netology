## Подготовка к выполнению
1. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.


Сделал [репозиторий](https://github.com/evgeniy-skt/ansible-playbook)

2. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.


[Сделал](https://github.com/evgeniy-skt/ansible-playbook/tree/main/playbook)

3. Подготовьте хосты в соотвтествии с группами из предподготовленного playbook.


[Сделал](https://github.com/evgeniy-skt/ansible-playbook/blob/main/docker-compose.yml)

4. Скачайте дистрибутив [java](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) и положите его в директорию `playbook/files/`.


Сделал

## Основная часть
1. Приготовьте свой собственный inventory файл `prod.yml`.
```
---
  elasticsearch:
    hosts:
      elastic:
        ansible_connection: docker
  kibana:
    hosts:
      kibana:
        ansible_connection: docker
```
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает kibana.
```
- name: Install Kibana
  hosts: kibana
  tasks:
    - name: Upload tar.gz kibana from remote URL
      ansible.builtin.get_url:
        url: "https://github.com/elastic/kibana/archive/refs/tags/v-{{ kibana_version }}.tar.gz"
        dest: "/tmp/kibana-{{ kibana_version }}.tar.gz"
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: get_kibana
      until: get_kibana is succeeded
      tags: kibana
    - name: Create directrory for kibana
      ansible.builtin.file:
        state: directory
        path: "{{ kibana_home }}"
      tags: kibana
    - name: Extract kibana in the installation directory
      become: true
      ansible.builtin.unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ kibana_home }}/bin/kibana"
      tags:
        - kibana
    - name: Set environment kibana
      become: true
      ansible.builtin.template:
        src: templates/kbn.sh.j2
        dest: /etc/profile.d/kbn.sh
      tags: kibana

```
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.


Использую

4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.


Так и есть

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
![lint_errors](https://github.com/evgeniy-skt/devops-netology/blob/main/screenshots/8_2_lint_empty_errors.png)
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
![check](https://github.com/evgeniy-skt/devops-netology/blob/main/screenshots/8_2_ansible_check.png)
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
![diff](https://github.com/evgeniy-skt/devops-netology/blob/main/screenshots/8_2_ansible_diff.png)
![diff_1_1](https://github.com/evgeniy-skt/devops-netology/blob/main/screenshots/8_2_ansible_diff_1_1.png)
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
![diff2](https://github.com/evgeniy-skt/devops-netology/blob/main/screenshots/8_2_ansible_diff2.png)
![diff2](https://github.com/evgeniy-skt/devops-netology/blob/main/screenshots/8_2_ansible_diff2_1.png)
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.


[Сделал](https://github.com/evgeniy-skt/ansible-playbook/blob/main/README.md)

10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.


[Сделал]([Сделал](https://github.com/evgeniy-skt/ansible-playbook/blob/main/docker-compose.yml))
