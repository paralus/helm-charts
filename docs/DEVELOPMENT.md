# Developing `rcloud` helm chart

This document outlines steps to create a development setup locally using a `kind` cluster.
The steps will be similar to using on a external cluster, but with some changes to get it working locally.

## `values.yaml` file updates

You might have to modify the following values in
[`values.yaml`](https://github.com/RafayLabs/rcloud-helm/blob/main/charts/rcloud/values.yaml)
file to make it working locally.

- Switch kratos to development mode by setting `kratos.kratos.development` to `true`
- Enable postgresql and elasticsearch by setting `deploy.postgres.enable` and `deploy.elasticsearch.enable` to `true`
- [OPTIONAL] Change the host under `ingress.host` to use a different hostname
- [OPTIONAL] Change the images under `images` to a custom image if you want to try with your custom images

## Setup a kind cluster

Create a kind cluster with the following config. This config is necessary to setup an ingress locally.

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
```

You can create a kind cluster by doing:

```shell
kind create cluster --config kind.config
```

_You can optionally pass in a name for the kind cluster if you want._

## Install ingress controller

Run the following command to install the ingress controller.

```shell
kubectl apply --filename \
    https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```

You can check for ingress controller to be up using the following command:

```shell
kubectl wait --namespace ingress-nginx \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/component=controller \
    --timeout=90s
```

## Setting up the domain locally

Since we are mapping the ingress to a domain by default, you will have to add the entry into you `/etc/hosts` file.

You can get the kind control plane ip using the following command:

```shell
docker container inspect kind-control-plane --format '{{ .NetworkSettings.Networks.kind.IPAddress }}'
```

You have to add this ip into you `/etc/hosts` file by adding something like the following:

```
172.18.0.2 console.ingress.local
```

`ingress.local` can be replaced with the hostname you provided in the
[`values.yaml`](https://github.com/RafayLabs/rcloud-helm/blob/main/charts/rcloud/values.yaml)
file under `ingress.host`. For example, if you have
`chart-example.com`, it would be `console.chart-example.com`.

## Run helm install

Now that you have everything up and ready, just run helm install command using:

``` shell
helm upgrade --install <name> .
```

*You should now be able to access the web ui in the hsot you specified under `ingress.host`.*
