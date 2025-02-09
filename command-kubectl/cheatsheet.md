## Common `kubectl` Commands in Kubernetes

### Cluster Information

- `kubectl cluster-info`  
  Display information about the Kubernetes cluster.

- `kubectl get nodes`  
  List all nodes in the cluster.

- `kubectl describe node <node_name>`  
  Show detailed information about a specific node.

- `kubectl version`  
  Display the versions of `kubectl` and the Kubernetes cluster.

### Working with Pods

- `kubectl get pods`  
  List all pods in the default namespace.

- `kubectl get pods -n <namespace>`  
  List all pods in a specific namespace.

- `kubectl describe pod <pod_name>`  
  Show detailed information about a specific pod.

- `kubectl logs <pod_name>`  
  View logs from a specific pod.

- `kubectl logs -f <pod_name>`  
  Stream live logs from a specific pod.

- `kubectl exec -it <pod_name> -- /bin/bash`  
  Access an interactive shell within a pod.

- `kubectl port-forward <pod_name> <local_port>:<remote_port>`  
  Forward a local port to a port on a pod.

### Managing Deployments

- `kubectl get deployments`  
  List all deployments in the default namespace.

- `kubectl create deployment <deployment_name> --image=<image_name>`  
  Create a deployment with a specific image.

- `kubectl delete deployment <deployment_name>`  
  Delete a specific deployment.

- `kubectl rollout status deployment/<deployment_name>`  
  Monitor the rollout status of a deployment.

- `kubectl scale deployment <deployment_name> --replicas=<number>`  
  Scale a deployment to a specified number of replicas.

### Services and Networking

- `kubectl get services`  
  List all services in the default namespace.

- `kubectl describe service <service_name>`  
  Show detailed information about a specific service.

- `kubectl expose deployment <deployment_name> --type=<service_type> --port=<port>`  
  Expose a deployment as a service.

### Working with Namespaces

- `kubectl get namespaces`  
  List all namespaces.

- `kubectl create namespace <namespace_name>`  
  Create a new namespace.

- `kubectl delete namespace <namespace_name>`  
  Delete a specific namespace.

### Configuration Management

- `kubectl apply -f <config_file>.yaml`  
  Apply configuration from a YAML file.

- `kubectl delete -f <config_file>.yaml`  
  Delete resources defined in a YAML file.

- `kubectl edit <resource_type> <resource_name>`  
  Edit the configuration of a specific resource interactively.

### Troubleshooting

- `kubectl logs <pod_name>`  
  View logs from a specific pod.

- `kubectl logs -f <pod_name>`  
  Stream live logs from a specific pod.

- `kubectl describe pod <pod_name>`  
  Show detailed information about a specific pod.

- `kubectl exec -it <pod_name> -- /bin/bash`  
  Access an interactive shell within a pod.

- `kubectl top nodes`  
  Display resource usage of nodes.

- `kubectl top pods`  
  Display resource usage of pods.

### Context and Configuration Management

- `kubectl config get-contexts`  
  List all available contexts.

- `kubectl config current-context`  
  Display the current context.

- `kubectl config use-context <context_name>`  
  Switch to a different context.

- `kubectl config view`  
  Display the current kube-config settings.

### Additional Commands

- `kubectl get all`  
  List all resources in the current namespace.

- `kubectl get events`  
  List events in the cluster.

- `kubectl get componentstatuses`  
  Check the status of cluster components.

- `kubectl explain <resource>`  
  Display detailed information about a specific resource.
