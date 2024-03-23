# a433-microservices Proyek Akhir
Repository ini digunakan untuk kebutuhan kelas Belajar Membangun Arsitektur Microservices

## 1. Deploy RabbitMQ Menggunakan Helm
```
kubectl create namespace marketplace
helm install my-release oci://registry-1.docker.io/bitnamicharts/rabbitmq --namespace marketplace
```

```
Credentials:
Credentials:
    echo "Username      : user"
    echo "Password      : $(kubectl get secret --namespace marketplace my-release-rabbitmq -o jsonpath="{.data.rabbitmq-password}" | base64 -d)"
    echo "ErLang Cookie : $(kubectl get secret --namespace marketplace my-release-rabbitmq -o jsonpath="{.data.rabbitmq-erlang-cookie}" | base64 -d)"

Note that the credentials are saved in persistent volume claims and will not be changed upon upgrade or reinstallation unless the persistent volume claim has been deleted. If this is not the first installation of this chart, the credentials may not be valid.
This is applicable when no passwords are set and therefore the random password is autogenerated. In case of using a fixed password, you should specify it when upgrading.
More information about the credentials may be found at https://docs.bitnami.com/general/how-to/troubleshoot-helm-chart-issues/#credential-errors-while-upgrading-chart-releases.

RabbitMQ can be accessed within the cluster on port 5672 at my-release-rabbitmq.marketplace.svc.cluster.local

To access for outside the cluster, perform the following steps:

To Access the RabbitMQ AMQP port:

    echo "URL : amqp://127.0.0.1:5672/"
    kubectl port-forward --namespace marketplace svc/my-release-rabbitmq 5672:5672

To Access the RabbitMQ Management interface:

    echo "URL : http://127.0.0.1:15672/"
    kubectl port-forward --namespace marketplace svc/my-release-rabbitmq 15672:15672
```
### Expose
```
kubectl expose service my-release-rabbitmq --type=NodePort --name=my-release-rabbitmq-ext -n marketplace
```
## 2. Deploy Istio
```
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.21.0
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
kubectl label namespace marketplace istio-injection=enabled
```
## 3. Deploy Layanan Order dan Shipping
```
kubectl apply -f order-service.yml -n marketplace

kubectl apply -f shipping-service.yml -n marketplace
```

## 4. Deploy Gateway dan Virtual Service Istio
```
kubectl apply -f gateway.yml -n marketplace
```

## 5. Vertifikasi
```
kubectl get all
kubectl get gateway -n marketplace
kubectl get virtualservice -n marketplace
```

## 6. Tunnel
minikube tunnel

## 7. Curl order
curl -X POST -H "Content-Type: application/json" -d '{
    "order": {
        "book_name": "Harry Potter",
        "author": "J.K Rowling",
        "buyer": "Fikri Helmi Setiawan",
        "shipping_address": "Jl. Batik Kumeli no 50 Bandung"
    }
}' http://10.96.112.191/order

## 8. Cek log Shipping
```
kubectl logs shipping-68744669dd-t77jc

> shipping-service@1.0.0 start
> node index.js

Server running at 3001
Order received: {"book_name":"Harry Potter","author":"J.K Rowling","buyer":"Fikri Helmi Setiawan","shipping_address":"Jl. Batik Kumeli no 50 Bandung"}
** Will be shipped soon! **

Order received: {"book_name":"Harry Potter","author":"J.K Rowling","buyer":"Afnan","shipping_address":"Jl. Batik Kumeli no 50 Bandung"}
** Will be shipped soon! **
```
