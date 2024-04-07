# kubernetes-autoscaling-iac
## prérequis 
- OS Ubuntu
- docker installé <a href="https://docs.docker.com/engine/install/ubuntu/" target="_blank">guide d'.nstalation</a>
- microk8s installé `sudo snap install micork8s --classic`
## étapes 
#### cloner la repo 
`git clone https://github.com/riad-999/kubernetes-autoscaling-iac.git` </br>
`cd kubernetes-autoscaling-iac`
#### executer le script bash, mais d'abord if fault changer le user au root
`sudo su` </br>
`chmod +x deploy.sh` </br>
`./deploy.sh` 
#### consulter 
Application web sur <b>http://localhost</b> </br>
Grafana sur <b>http://localhost:3000</b>

#### Dcokerfiles 
Les images docker de node et react utilisés sont héberges dans mon dockerhub, si vous voulez les dockerfiles utilisé pour générer ces images consultez le folder dockerfiles.
