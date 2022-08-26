# ztka

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.1.3](https://img.shields.io/badge/AppVersion-v0.1.3-informational?style=flat-square)

A Helm chart for Paralus ZTKA.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Paralus Team |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | contour | 7.8.0 |
| https://charts.bitnami.com/bitnami | postgresql | 11.1.9 |
| https://helm.elastic.co | elasticsearch | 7.17.1 |
| https://helm.elastic.co | filebeat | 7.17.1 |
| https://k8s.ory.sh/helm/charts | kratos | 0.22.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| analytics.enable | bool | `true` |  |
| analytics.gaTrackingID | string | `"UA-230674306-1"` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| contour | object | contour subchart overwrite | the chart will overwrite some values of contour subchart. |
| contour.envoy.service.annotations | object | `{}` | Annotations for Envoy service. |
| deploy.contour.enable | bool | `true` | auto install contour ingress controller |
| deploy.contour.tls | object | `{}` | TLS properties of the virtual host |
| deploy.elasticsearch.address | string | `""` | Elasticsearch address. Required when `deploy.elasticsearch.enable` is unset. |
| deploy.elasticsearch.enable | bool | `false` | Elasticsearch instance is auto deployed and managed by Helm release when true. |
| deploy.filebeat.enable | bool | `true` | Filebeat is used to collect audit logs into the system. You can disable this if you don't want audit logs. |
| deploy.filebeat.indexPrefix | string | `"ralog"` | You can use this to config the index prefixes for elasticsearch.  This has to match with your filebeat config in `filebeat.daemonset.filebeatConfig.filebeat.yml` |
| deploy.kratos.adminAddr | string | `""` | Kratos admin address. Required when `deploy.kratos.enable` is unset |
| deploy.kratos.enable | bool | `true` | Kratos instance is auto deployed and managed by Helm release when true. |
| deploy.kratos.publicAddr | string | `""` | Kratos public address. Required when `deploy.kratos.enable` is unset |
| deploy.kratos.smtpConnectionURI | string | `"smtps://test:test@mypost:1025/?skip_ssl_verify=true"` | SMTP connection URI that used by auto-deployed kratos for sending mails for example, account recovery etc. |
| deploy.postgresql.address | string | `""` | Postgresql address for example, "localhost:5432". Required when `deploy.postgresql.enable` is unset and dsn is not specified. |
| deploy.postgresql.database | string | `""` | Postgresql database name. Required when `deploy.postgresql.enable` is unset and dsn is not specified. |
| deploy.postgresql.dsn | string | `""` | Postgresql DSN for example, "postgres://user:password@host:5432/db". Required when `deploy.postgresql.enable` is unset and individual components are not specified. Overrides individual components (address, username, password, database) |
| deploy.postgresql.enable | bool | `false` | Postgresql db is auto deployed and managed by Helm release when true. (It is recommended to manage your own DB instance separately or use DB services like Amazon RDS in production) |
| deploy.postgresql.password | string | `""` | Postgresql password. Required when `deploy.postgresql.enable` is unset and dsn is not specified. |
| deploy.postgresql.username | string | `""` | Postgresql username. Required when `deploy.postgresql.enable` is unset and dsn is not specified. |
| elasticsearch.minimumMasterNodes | int | `1` |  |
| elasticsearch.replicas | int | `1` |  |
| filebeat | object | filebeat subchart overwrite | the chart will overwrite some values of filebear subchart. |
| fqdn.coreConnectorSubdomain | string | `"*.core-connector"` | cluster communication |
| fqdn.domain | string | `"paralus.local"` | Root domain |
| fqdn.hostname | string | `"console"` | subdomain used for viewing dashboard |
| fqdn.userSubdomain | string | `"*.user"` | communication |
| imagePullSecrets | list | `[]` | If defined, uses a Secret to pull an image from a private Docker registry or repository |
| images.dashboard.name | string | `"dashboard"` |  |
| images.dashboard.repository | string | `"paralusio/dashboard"` | Paralus dashboard image |
| images.dashboard.tag | string | `"v0.1.1"` |  |
| images.paralus.name | string | `"paralus"` |  |
| images.paralus.repository | string | `"paralusio/paralus"` | Paralus paralus image |
| images.paralus.tag | string | `"v0.1.3"` |  |
| images.paralusInit.name | string | `"paralus-init"` |  |
| images.paralusInit.repository | string | `"paralusio/paralus-init"` | Paralus paralus initialize image |
| images.paralusInit.tag | string | `"v0.1.3"` |  |
| images.prompt.name | string | `"prompt"` |  |
| images.prompt.repository | string | `"paralusio/prompt"` | prompt image |
| images.prompt.tag | string | `"v0.1.1"` |  |
| images.pullPolicy | string | `"IfNotPresent"` | If defined, a imagePullPolicy applied to all deployments |
| images.relay.name | string | `"relay"` |  |
| images.relay.repository | string | `"paralusio/relay"` | relay image |
| images.relay.tag | string | `"v0.1.1"` |  |
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
| paralus.initialize.org | string | `"DefaultOrg"` | Organization name |
| paralus.initialize.orgDesc | string | `"Default Organization"` | Organization description |
| paralus.initialize.partner | string | `"DefaultPartner"` | Partner name |
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
| services.dashboard | object | `{"ports":[{"containerPort":80,"name":"nginx"}],"type":"ClusterIP"}` | dashboard service config |
| services.paralus | object | `{"ports":[{"containerPort":11000,"name":"http"},{"containerPort":10000,"name":"rpc"},{"containerPort":10001,"name":"relay-peering"}],"type":"ClusterIP"}` | paralus service config |
| services.prompt | object | `{"ports":[{"containerPort":7009,"name":"http"}],"type":"ClusterIP"}` | prompt service config |
| services.relay | object | `{"ports":[{"containerPort":443,"name":"https"}],"type":"ClusterIP"}` | relay service config |
| tolerations | list | `[]` |  |

