---
title: "Kubernetes"
category: "main"
---


== Links ==
* [https://microk8s.io/docs/ microk8s]
* [https://habr.com/company/southbridge/blog/340238/ (Без)болезненный NGINX Ingress]



== Networking ==
* [https://eng.lyft.com/announcing-cni-ipvlan-vpc-k8s-ipvlan-overlay-free-kubernetes-networking-in-aws-95191201476e Announcing cni-ipvlan-vpc-k8s: IPvlan overlay-free Kubernetes Networking in AWS]
  * [https://github.com/lyft/cni-ipvlan-vpc-k8s github cni-ipvlan-vpc-k8s]
* [https://habr.com/ru/company/flant/blog/329830/ Container Networking Interface (CNI) — сетевой интерфейс и стандарт для Linux-контейнеров]
* [https://itnext.io/kubernetes-networking-behind-the-scenes-39a1ab1792bb Kubernetes Networking: Behind the scenes]


<pre>
Because all ipvlan interfaces share the MAC address with the host interface, DHCP can only be used in conjunction with ClientID
</pre>


== Persistent volumes ==
* [https://vocon-it.com/2018/12/10/kubernetes-4-persistent-volumes-hello-world/ kubernetes-4-persistent-volumes-hello-world]
* [https://vocon-it.com/2018/12/20/kubernetes-local-persistent-volumes/ kubernetes-local-persistent-volumes]


== kubectl ==
<pre>
/home/.kube/config  (from /etc/kubernets/*adm)

kubectl


sudo kubectl get ns
sudo kubectl get secret -n kube-system
sudo kubectl describe secret kubernetes-dashboard-admin-token-nlzz8 -n kube-system

https://dashboard-k8s-java-dev.xpt.sqtools.ru

sudo kubectl get nodes
</pre>


=== join token ===
<pre>
sudo kubeadm token create --print-join-command
</pre>


=== remove node ===
<pre>
sudo kubectl drain k8s-worker1-java-platform-dev --ignore-daemonsets --delete-local-data
sudo kubectl delete node k8s-worker1-java-platform-dev
sudo kubectl get nodes
</pre>