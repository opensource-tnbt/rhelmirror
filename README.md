# rhel-local-mirrors

This is a set of playbooks to automate the local mirror creation
for RHEL repos in a system. It will perform two steps:
1. Subscribe the system into the RedHat network
2. Create local miror for the repos specified

## How to use
The playbooks expect a group of servers called ``rhel_mirrors`` to be
created. Please update the group in ansible inventory file inventory.ini.

Next, modify the values of values in vars/main.yml.

After that, just run ``ansible-playbook site.yml -i ./inventory.ini``

## RH subscription manager

On a Red Hat system, subscription of can be managed automatically
if you pass the right credentials:
* rhsm_username
* rhsm_password
* rhsm_poolid
* rhsm_consumer_name (Optional)

Subscription is enabled by default. If you want to disable
it, you can set to False the `subscribe_rhn` var.

If you need to limit the playbook to subscribe to your system, please run the
playbook with
--tags rhel_register

## Repo Destination

Repos will be downloaded to the location mentioned in repo_destination.
Please set it to appropriate value

## System preparation

In order to create mirrors, several packages need to be installed on the
system, and firewall or iptables rules need to be created to enable HTTP
access. In order to do it, several tasks tagged with `prepare_system` are
executed.

## Mirror creation

This playbook can create mirrors based on the subscribed repos. It relies on
a list of mirrors being defined, using the `mirrors` var:

It expects a list of List of RedHat repositories to be enabled. Please update
`rhsm_repos` variable.

To limit the playbook to just create the mirrors, please executed with
--tags create_miror

## Repo file to be used by clients.
Once the repos are downloaded, a `repo_filename`.repo will be created in
`/etc/yum.repos.d`. Use can move this file to clients.
