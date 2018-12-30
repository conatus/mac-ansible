# Ansible Mac OS X Configuration

Inspired by the work of [Adam Chainz](https://github.com/adamchainz/mac-ansible) and [Jeff Geerling](https://github.com/geerlingguy/mac-dev-playbook) this playbook sets up my Macs with Ansible.

## Usage

1. Install [Brew](https://brew.sh). While [Ansible can bootstrap Brew](https://github.com/geerlingguy/ansible-role-homebrew), this is a little more simple.
2. Use Brew to install Python: `brew install python`.
3. Install Ansible using Pip: `pip3 install ansible`.
4. Run playfile: `ansible-playbook playbook.yml`.

## Workarounds

[Due to](https://github.com/adamchainz/mac-ansible/issues/2) run:

```
defaults write com.googlecode.iterm2 PrefsCustomFolder -string `pwd`/roles/mac/files/iterm2
```

Before running the playbook from scratch.

After running for the first time you will need to manually install Spaceship Prompt and rerun the playbook with the shell tag.

```
npm install -g spaceship-prompt && rm ~/.zshrc
ansible-playbook playbook.yml --tags=shell
```

See [issue for further details](https://github.com/conatus/mac-ansible/issues/4).


