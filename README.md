# ANSIBLE PROJECT

<img src="./images/ansible.gif" width="500"/>

# Introduction

Previously created a [Terraform template](https://github.com/idanhoro/Terraform-project) that automates the process of provisioning our infrastructure in the Cloud.
In this project we are going to use in order to automate the whole configuration of the servers and
deploy our NodeWeightTracker application using Configuration Management practices.

# Project Overview

In this project i wrote  an Ansible playbooks to configure the servers created by [Terraform template](https://github.com/idanhoro/Terraform-project) and then, install the NodeWeightTracker application including all its dependencies.
In addition, we are ready to move to production. To achieve this we will need to provision 2 identical environments, one for staging and another for production.

<img src="./images/project_overview.png" width="700"/>

# Project Goals

- Use Terraform to provision the infrastructure
- Use Ansible to deploy the NodeWeightTracker application
- Create two environments: Staging and Production
- Both environments must be identical except for the size of the vms (production ones must be larger)

# Requirements

- [Terraform template](https://github.com/idanhoro/Terraform-project)
- Virtual Machine that will be the Ansible Controller.
- Free Okta developer account for account registration, login
- .env file for each environment. (Example at ansible\env_production\Example_env)
- Inventory file configure, [INI STYLE](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ini_inventory.html) Example:
```yaml
[production]
Production-Server-1 
      .
      .
  
[production:vars]
ansible_ssh_host=[[IP/DNS ADRESS]]
ansible_user=[[The username of ansible VM]]

VM_username=[[Host's username]]
App_folder=[[Name of the project directory]]
git_repo_url=[["https://github.com/idanhoro/bootcamp-app.git"]]
Controller_folder=[[Directory at ansible VM that should run from]]
env_level=[[Environment level]]

[staging]
Staging-Server-1
      .
      .
[staging:vars]
ansible_ssh_host=[[IP/DNS ADRESS]]
ansible_user=[[The username of ansible VM]]
VM_username=[[Host's username]]
App_folder=[[Name of the project directory]]
git_repo_url=[["https://github.com/idanhoro/bootcamp-app.git"]]
Controller_folder=[[Directory at ansible VM that should run from]]
env_level=[[Environment level]]
```


# Running instructions
Run the follow commands:
1) ```cd Ansible-project\setup```
2) ```terraform init```
3) ```terraform apply```
4) ``` cd Ansible-project\ansible```
5) ```ansible-playbook -i Inventory playbook.yml``` (Inventory+.env files required )
