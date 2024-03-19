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