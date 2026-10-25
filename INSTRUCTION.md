# Instructions

## 1. Apply the manifests

Apply the manifests in the following order (the namespace must exist before the pods that reference it):

```bash
kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/todoapp-pod.yml
kubectl apply -f .infrastructure/busybox.yml
```

Check that both pods are up and running:

```bash
kubectl get pods -n todoapp
```

You should see both `todoapp` and `busybox` in the `Running` state with `READY 1/1`.

## 2. Test the ToDo application using port-forward

Forward a local port to the `todoapp` pod's port 8000:

```bash
kubectl port-forward -n todoapp todoapp 8000:8000
```

This command keeps running in the terminal (the tunnel stays open while it runs). In a browser or a new terminal, check the endpoints:

```bash
curl http://localhost:8000/api/ready/
curl http://localhost:8000/api/health/
```

You can also open `http://localhost:8000/` in a browser to see the application's landing page.

Stop the port-forward with `Ctrl+C` when done.

## 3. Test the ToDo application using the busyboxplus:curl pod

Get the `todoapp` pod's internal IP address:

```bash
kubectl get pods -n todoapp -o wide
```

Note the IP address shown for the `todoapp` pod (e.g. `10.244.0.11`).

Exec into the `busybox` pod:

```bash
kubectl exec -it busybox -n todoapp -- sh
```

From inside the `busybox` shell, curl the `todoapp` pod directly using its IP and port 8000:

```bash
curl <TODOAPP_POD_IP>:8000/api/ready/
curl <TODOAPP_POD_IP>:8000/api/health/
```

Both should return `Ready` and `Healthy` respectively. Exit the shell with `exit` when done.
