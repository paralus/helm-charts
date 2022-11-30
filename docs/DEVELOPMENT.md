# Developing `ztka` helm chart

This document outlines steps to create a development setup locally using a `kind` cluster.
The steps will be similar to using on a external cluster, but with some changes to get it working locally.

## `values.yaml` file updates

You might have to modify the following values in
[`values.yaml`](https://github.com/paralus/helm-charts/blob/main/charts/ztka/values.yaml)
file to make it working locally.

- Switch kratos to development mode by setting `kratos.kratos.development` to `true`
- Enable postgresql and elasticsearch by setting `deploy.postgres.enable` and `deploy.elasticsearch.enable` to `true`
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
docker container inspect <cluster-name>-control-plane --format '{{ .NetworkSettings.Networks.kind.IPAddress }}'
```

> `<cluster-name>` would be the name that you gave to your kind cluster

You have to add this ip into you `/etc/hosts` file by adding something like the following:

```
172.18.0.2 console.paralus.local
```

*When running locally use `paralus.local` as your host. This is what
will be set by default for the value of `fqdn.domain` in your
[`values.yaml`](https://github.com/paralus/helm-charts/blob/main/charts/ztka/values.yaml)
file. If you want to change, make sure you update the host in all the places where we mention `paralus.local`.*

## Run helm install

Now that you have everything up and ready, just run helm install command using:

``` shell
helm upgrade --install <name> .
```

*You should now be able to access the web ui in the host you specified under `fqdn.domain`.*

## Resetting admin user's password

You can get the recoverly link for the admin user by running the following.

``` shell
export RELEASE_NAME="my-release"
export RUSER="admin@paralus.local"
kubectl exec -it "$RELEASE_NAME-postgresql-0" -- bash \
  -c "PGPASSWORD=admindbpassword psql -h localhost -U admindbuser admindb \
-c \"select id from identities where traits->>'email' = '$RUSER' limit 1;\" -tA \
| xargs -I{} curl -X POST http://$RELEASE_NAME-kratos-admin/admin/recovery/link \
-H 'Content-Type: application/json' -d '{\"expires_in\":\"10m\",\"identity_id\":\"{}\"}'"
```

When run, you will get something like:

``` json
{"recovery_link":"http://console.paralus.local/self-service/recovery?flow=83a66af9-600a-44cc-905e-819298bfa07a&token=EiZ9EpWekGYBPqHHtF87M6Jq61YthdUG","expires_at":"2022-04-27T10:19:28.695433325Z"}
```

You can go to that link and reset the password for your admin user.

## Importing a cluster

**These steps will be obsolete soon**

Firstly, go through the UI flow to create a new cluster and download the bootstrap yaml.

- Update your ingress controlle arg list and add `--enable-ssl-passthrough=true` in the values
- Update your ingress hosts to point to specific cluster id, for example instead if your cluster id is `abdc123` update the ingresses to `abcd123.core-connector.paralus.local` and `abcd123.user.paralus.local` instead of wildcard versions of the same
- Add the above hosts to tls section of ingress as well (don't add a tls secret)
- Add `abcd123.core-connector.paralus.local` and `abcd123.user.paralus.local` to /etc/hosts pointing to the same ip

Now you can apply your bootstrap and have the system able to connect to the target cluster.
