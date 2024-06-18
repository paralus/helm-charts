# ztka

A Helm chart for Paralus ZTKA.

![Version: 0.2.9](https://img.shields.io/badge/Version-0.2.9-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.2.8](https://img.shields.io/badge/AppVersion-v0.2.8-informational?style=flat-square)

This chart bootstraps the Paralus deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes v1.18+

## Get Repo Info

```console
helm repo add paralus https://paralus.github.io/helm-charts
helm repo update
```

## Install Chart

**Important:** only helm3 is supported

```console
helm install [RELEASE_NAME] paralus/ztka -n paralus  \
--create-namespace \
--set deploy.postgresql.enable=true
```

The command deploys Paralus on the Kubernetes cluster in the default configuration.

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME] -n paralus
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] paralus/ztka --install -n paralus --create-namespace
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

### Upgrading to chart v0.1.9

The chart `v0.1.9` introduced support for both database and elasticsearch as a back-end for auditlog storage. Defaults to database storage. So upgrading from older version to v0.1.9 may affect the auditing functionality.

It is advised to use below command when upgrade to v0.1.9 without breaking auditlog functionality.

```console
helm upgrade [RELEASE_NAME] paralus/ztka -n paralus \
-f https://raw.githubusercontent.com/paralus/helm-charts/main/examples/values.elasticsearch.yaml \
--version 0.1.9
```

_It is recommended to keep using either database or elasticsearch for auditing storage to avoid auditlog data loss throughout upgrades._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
helm show values paralus/ztka
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://fluent.github.io/helm-charts | fluent-bit | 0.20.8 |
| https://helm.elastic.co | elasticsearch | 7.17.1 |
| https://helm.elastic.co | filebeat | 7.17.1 |
| https://k8s.ory.sh/helm/charts | kratos | 0.29.0 |
| https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami | contour | 7.8.0 |
| https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami | postgresql | 11.1.9 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Additional labels to add to all resources |
| affinity | object | `{}` |  |
| auditLogs.storage | string | `"database"` | database(postgres) by default |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| contour | object | contour subchart overwrite | the chart will overwrite some values of contour subchart. |
| contour.envoy.hostPorts | object | `{"http":80,"https":443}` | Envoy host ports. |
| contour.envoy.service.annotations | object | `{}` | Annotations for Envoy service. |
| contour.envoy.service.type | string | `"LoadBalancer"` | Type of Envoy service to create. |
| deploy.contour.enable | bool | `true` | auto install contour ingress controller |
| deploy.contour.tls | object | `{}` | TLS properties of the virtual host |
| deploy.elasticsearch.address | string | `""` | Elasticsearch address. Required when `deploy.elasticsearch.enable` is unset. |
| deploy.elasticsearch.enable | bool | `false` | Elasticsearch instance is auto deployed and managed by Helm release when true. |
| deploy.filebeat.enable | bool | `false` | Filebeat is used to collect audit logs into the system via elasticsearch. You can disable this if you don't want audit logs or you want to store audit logs into database. |
| deploy.filebeat.indexPrefix | string | `"ralog"` | You can use this to config the index prefixes for elasticsearch.  This has to match with your filebeat config in `filebeat.daemonset.filebeatConfig.filebeat.yml` |
| deploy.fluentbit.enable | bool | `true` | Fluentbit is used to collect audit logs into the system via a database. You can disable this if you don't want audit logs or you want to push audit logs to elasticsearch. |
| deploy.kratos.adminAddr | string | `""` | Kratos admin address. Required when `deploy.kratos.enable` is unset |
| deploy.kratos.enable | bool | `true` | Kratos instance is auto deployed and managed by Helm release when true. |
| deploy.kratos.publicAddr | string | `""` | Kratos public address. Required when `deploy.kratos.enable` is unset |
| deploy.kratos.smtpConnectionURI | string | `"smtps://test:test@mypost:1025/?skip_ssl_verify=true"` | SMTP connection URI that used by auto-deployed kratos for sending mails for example, account recovery etc. |
| deploy.postgresql.address | string | `""` | Postgresql address for example, "localhost:5432". Required when `deploy.postgresql.enable` is unset and dsn is not specified. |
| deploy.postgresql.database | string | `""` | Postgresql database name. Required when `deploy.postgresql.enable` is unset and dsn is not specified. |
| deploy.postgresql.dsn | string | `""` | Postgresql DSN for example, "postgres://user:password@host:5432/db". Required when `deploy.postgresql.enable` is unset and individual components are not specified. Overrides individual components (address, username, password, database) |
| deploy.postgresql.enable | bool | `false` | Postgresql db is auto deployed and managed by Helm release when true. (It is recommended to manage your own DB instance separately or use DB services like Amazon RDS in production) |
| deploy.postgresql.password | string | `""` | Postgresql password. Required when `deploy.postgresql.enable`   is unset and dsn is not specified. |
| deploy.postgresql.username | string | `""` | Postgresql username. Required when `deploy.postgresql.enable` is unset and dsn is not specified. |
| elasticsearch.minimumMasterNodes | int | `1` |  |
| elasticsearch.replicas | int | `1` |  |
| filebeat | object | filebeat subchart overwrite | the chart will overwrite some values of filebear subchart. |
| fluent-bit.existingConfigMap | string | `"fluentbit-config"` |  |
| fqdn.coreConnectorSubdomain | string | `"*.core-connector"` | cluster communication |
| fqdn.domain | string | `"paralus.local"` | Root domain |
| fqdn.hostname | string | `"console"` | subdomain used for viewing dashboard |
| fqdn.userSubdomain | string | `"*.user"` | communication |
| hooks.enable | bool | `true` |  |
| imagePullSecrets | list | `[]` | If defined, uses a Secret to pull an image from a private Docker registry or repository |
| images.dashboard.name | string | `"dashboard"` |  |
| images.dashboard.repository | string | `"paralusio/dashboard"` | Paralus dashboard image |
| images.dashboard.tag | string | `"v0.2.3"` |  |
| images.paralus.name | string | `"paralus"` |  |
| images.paralus.repository | string | `"paralusio/paralus"` | Paralus paralus image |
| images.paralus.tag | string | `"v0.2.8"` |  |
| images.paralusInit.name | string | `"paralus-init"` |  |
| images.paralusInit.repository | string | `"paralusio/paralus-init"` | Paralus paralus initialize image |
| images.paralusInit.tag | string | `"v0.2.8"` |  |
| images.prompt.name | string | `"prompt"` |  |
| images.prompt.repository | string | `"paralusio/prompt"` | prompt image |
| images.prompt.tag | string | `"v0.1.3"` |  |
| images.pullPolicy | string | `"IfNotPresent"` | If defined, a imagePullPolicy applied to all deployments |
| images.relay.name | string | `"relay"` |  |
| images.relay.repository | string | `"paralusio/relay"` | relay image |
| images.relay.tag | string | `"v0.1.8"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.tls | list | `[]` | Ingress TLS for console |
| kratos | object | kratos subchart overwrite | the chart will overwrite some values of kratos subchart. |
| nodeSelector | object | `{}` |  |
| paralus.automigrate | bool | `true` | Enable paralus migrations |
| paralus.initialize.adminEmail | string | `"admin@paralus.local"` | Admin email address |
| paralus.initialize.adminFirstName | string | `"Admin"` | Admin first name |
| paralus.initialize.adminLastName | string | `"User"` | Admin last name |
| paralus.initialize.org | string | `"ParalusOrg"` | Organization name |
| paralus.initialize.orgDesc | string | `"Default Organization"` | Organization description |
| paralus.initialize.partner | string | `"Paralus"` | Partner name |
| paralus.initialize.partnerDesc | string | `"Default Partner"` | Partner description |
| paralus.initialize.partnerHost | string | `"paralus.local"` | Partner host |
| podAnnotations | object | `{}` | Annotations for the all deployed pods |
| podSecurityContext | object | `{}` |  |
| postgresql.auth | object | `{"database":"admindb","enablePostgresUser":false,"existingSecret":"postgresql","password":"admindbpassword","username":"admindbuser"}` | When `deploy.postgresql.enable` is true postgres instance is created with this credentials. |
| postgresql.dbAddr | string | `""` |  |
| replicaCount | int | `1` | Number of replicas in deployment |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| services.dashboard | object | `{"name":"dashboard","ports":[{"containerPort":80,"name":"nginx"}],"type":"ClusterIP"}` | dashboard service config |
| services.paralus | object | `{"name":"paralus","ports":[{"containerPort":11000,"name":"http"},{"containerPort":10000,"name":"rpc"},{"containerPort":10001,"name":"relay-peering"}],"type":"ClusterIP"}` | paralus service config |
| services.prompt | object | `{"name":"prompt","ports":[{"containerPort":7009,"name":"http"}],"type":"ClusterIP"}` | prompt service config |
| services.relay | object | `{"name":"relay","ports":[{"containerPort":443,"name":"https"}],"type":"ClusterIP"}` | relay service config |
| tolerations | list | `[]` |  |

