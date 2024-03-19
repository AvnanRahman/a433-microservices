# Proyek Ke-2 Kriteria 3: Deploy Aplikasi ke Kubernetes
Repository ini digunakan untuk kebutuhan kelas Belajar Membangun Arsitektur Microservices

# Buat Namespace
```
kubectl create namespace karsajobs
```
# Terapkan Konfigurasi YAML ke Namespace
```
kubectl apply -f backend/ -n karsajobs

kubectl apply -f frontend/ -n karsajobs

kubectl apply -f mongodb/ -n karsajobs

```
# See Resource in Namespace
```
kubectl get all -n karsajobs
```

# Cleanup
```
kubectl delete -f backend/ -n karsajobs

kubectl delete -f frontend/ -n karsajobs

kubectl delete -f mongodb/ -n karsajobs

```

# Monitoring 
Create namespace
```
kubectl create namespace monitoring
```
Install Helm
```
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

Add Repo
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

Deploy Prometheus dan Grafana
```
helm install prometheus prometheus-community/prometheus -n monitoring
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext -n monitoring
minikube service prometheus-server-ext -n monitoring


helm install grafana grafana/grafana -n monitoring
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext -n monitoring
minikube service grafana-ext -n monitoring
```

Check password untuk user admin grafana
```
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Login ke grafana dengan URL yang sudah di expose, username admin dan password yang sudah di generate.
Tambahkan data source Prometheus, masukan nilai URL saat mengexpose service prometheus-server-ext

Login dan Create panel, import dari https://grafana.com/grafana/dashboards/6417-kubernetes-cluster-prometheus/ atau ID 6417

Referensi: https://semaphoreci.com/blog/prometheus-grafana-kubernetes-helm

