## FIRST RUN KUBERNETES -> THEN BUILD APP-> BUILD IMAGE
### Kubernetes:
https://spring.io/guides/gs/spring-boot-kubernetes/  
https://www.youtube.com/watch?v=7o7e8OAAWyg
https://medium.com/@javatechie/kubernetes-tutorial-run-deploy-spring-boot-application-in-k8s-cluster-using-yaml-configuration-3b079154d232
https://www.kindsonthegenius.com/deploy-springboot-application-to-kubernetesminikube-using-deployment-yaml-file/
https://github.com/Java-Techie-jt/springboot-k8s-yaml
4. minikube start
4. minikube status
2. minikube dashboard
   1. minikube dashboard --url: Open Dashboard with URL 
3. eval $(minikube docker-env)  #MOST IMPORTANT THING

### Java:
mvn package
java -jar target/*.jar
http :8080
http :8080/actuator/health
```bash
docker build --build-arg JAR_FILE=target/minikube-demo.jar -t minikube-demo:1.0 . 
OR ./mvnw spring-boot:build-image # use internal docker file use  Paketo Buildpack docker.io/paketobuildpacks/builder:base
docker run -i --rm -p 8080:8080 minikube-demo:1.0   
```

2. 


# KUBER Deployment
```bash
kubectl apply -f k8s-deployment.yml #deploy the application to the cluster
kubectl get deployments #check the deployment status
#NAME            READY   UP-TO-DATE   AVAILABLE   AGE
#minikube-demo   1/1     1            1           4m37s

kubectl get pods #get pods information using
#minikube-demo-7fff76444f-fs2dj   1/1     Running   0          4m44s

kubectl logs minikube-demo-7fff76444f-fs2dj 
kubectl delete -n default deployment minikube-demo
```

Error from server (BadRequest): container "minikube-demo" in pod "minikube-demo-7fff76444f-fs2dj" is waiting to start: trying and failing to pull image
It means: you did not create image into current cluster:
## YOU DID NOT eval $(minikube docker-env) command before building your image into docker.



## K8S Service

```bash
kubectl get services 
#NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
#kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   8d

kubectl apply -f k8s-service.yml #deploy the application to the cluster
kubectl get services #check the deployment status
#NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
#kubernetes              ClusterIP   10.96.0.1      <none>        443/TCP          8d
#minikube-demo-service   NodePort    10.96.54.236   <none>        8080:31224/TCP   3s
kubectl get nodes -o wide
#NAME       STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
#minikube   Ready    control-plane   8d    v1.26.1   192.168.49.2   <none>        Ubuntu 20.04.5 LTS   5.15.49-linuxkit   docker://20.10.23
kubectl delete -n default service minikube-demo-service
```

```bash
minikube ip    
#192.168.49.2

``````bash
kubectl get all  
NAME                                READY   STATUS    RESTARTS   AGE
pod/minikube-demo-bc6876b4c-98w6s   1/1     Running   0          4m46s
pod/minikube-demo-bc6876b4c-mnfnm   1/1     Running   0          4m47s

NAME                            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes              ClusterIP   10.96.0.1        <none>        443/TCP          8d
service/minikube-demo-service   NodePort    10.106.155.117   <none>        8080:30152/TCP   8m9s

NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/minikube-demo   2/2     2            2           8m34s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/minikube-demo-7fff76444f   0         0         0       8m34s
replicaset.apps/minikube-demo-bc6876b4c    2         2         2       4m47s
replicaset.apps/minikube-demo-c8ddbdc5     0         0         0       5m5s

```
```bash
kubectl cluster-info
#Kubernetes control plane is running at https://127.0.0.1:49820
#CoreDNS is running at https://127.0.0.1:49820/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

NODE_IP + Cluster PORT




kubectl create deployment minikube-demo-deployment --image=minikube-demo:1.0 --dry-run -o=yaml > deployment.yaml
echo --- >> deployment.yaml
kubectl create service clusterip minikube-demo-service --tcp=8080:8080 --dry-run -o=yaml >> deployment.yaml

kubectl apply -f deployment.yaml     
deployment.apps/demo created
service/minikube-demo created

kubectl port-forward service/minikube-demo  8080:8080
