# Proyek Ke-2 Kriteria 3: Deploy Aplikasi ke Kubernetes
Repository ini digunakan untuk kebutuhan kelas Belajar Membangun Arsitektur Microservices

# Buat Namespace
```
kubectl create namespace karsajobs
```
# Terapkan Konfigurasi YAML ke Namespace
```
kubectl apply -f backend/karsajobs-deployment.yml -n karsajobs
kubectl apply -f backend/karsajobs-service.yml -n karsajobs
kubectl apply -f frontend/karsajobs-ui-deployment.yml -n karsajobs
kubectl apply -f frontend/karsajobs-ui-service.yml -n karsajobs
kubectl apply -f mongodb/mongo-configmap.yml -n karsajobs
kubectl apply -f mongodb/mongo-secret.yml -n karsajobs
kubectl apply -f mongodb/mongo-pv-pvc.yml -n karsajobs
kubectl apply -f mongodb/mongo-service.yml -n karsajobs
kubectl apply -f mongodb/mongo-statefulset.yml -n karsajobs
```
# See Resource in Namespace
```
kubectl get all -n karsajobs
```