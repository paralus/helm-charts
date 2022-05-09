# rcloud

![Version: 0.0.1-alpha.1](https://img.shields.io/badge/Version-0.0.1--alpha.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.0.1](https://img.shields.io/badge/AppVersion-v0.0.1-informational?style=flat-square)

A Helm chart for Rcloud.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Rafay |  |  |

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
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| contour | object | contour subchart overwrite | the chart will overwrite some values of contour subchart. |
| contour.envoy.service.annotations | object | `{}` | Annotations for Envoy service. |
| deploy.contour.enable | bool | `false` | install contour ingress controller when true and also setup HTTPProxy resources. |
| deploy.contour.tls | object | `{}` | TLS properties of the virtual host |
| deploy.elasticsearch.address | string | `""` | Elasticsearch address. Required when `deploy.elasticsearch.enable` is unset. |
| deploy.elasticsearch.enable | bool | `false` | Elasticsearch instance is auto deployed and managed by Helm release when true. |
| deploy.filebeat.enable | bool | `true` | Filebeat is used to collect audit logs into the system. You can disable this if you don't want audit logs. |
| deploy.filebeat.indexPrefix | string | `"ralog"` | You can use this to config the index prefixes for elasticsearch.  This has to match with your filebeat config in `filebeat.daemonset.filebeatConfig.filebeat.yml` |
| deploy.kratos.adminAddr | string | `""` | Kratos admin address. Required when `deploy.kratos.enable` is unset |
| deploy.kratos.enable | bool | `true` | Kratos instance is auto deployed and managed by Helm release when true. |
| deploy.kratos.publicAddr | string | `""` | Kratos public address. Required when `deploy.kratos.enable` is unset |
| deploy.kratos.smtpConnectionURI | string | `"smtps://test:test@mypost:1025/?skip_ssl_verify=true"` | SMTP connection URI that used by auto-deployed kratos for sending mails for example, account recovery etc. |
| deploy.postgresql.address | string | `""` | Postgresql address for example, "localhost:5432". Required when `deploy.postgresql.enable` is unset |
| deploy.postgresql.database | string | `""` | Postgresql database name. Required when `deploy.postgresql.enable` is unset. |
| deploy.postgresql.enable | bool | `false` | Postgresql db is auto deployed and managed by Helm release when true. (It is recommended to manage your own DB instance separately or use DB services like Amazon RDS in production) |
| deploy.postgresql.password | string | `""` | Postgresql password. Required when `deploy.postgresql.enable` is unset. |
| deploy.postgresql.username | string | `""` | Postgresql username. Required when `deploy.postgresql.enable` is unset. |
| elasticsearch.minimumMasterNodes | int | `1` |  |
| elasticsearch.replicas | int | `1` |  |
| filebeat | object | filebeat subchart overwrite | the chart will overwrite some values of filebear subchart. |
| imagePullSecrets | list | `[]` | If defined, uses a Secret to pull an image from a private Docker registry or repository |
| images.prompt.name | string | `"prompt"` |  |
| images.prompt.repository | string | `"registry.dev.rafay-edge.net/akshay196/prompt"` | prompt image |
| images.prompt.tag | string | `""` |  |
| images.pullPolicy | string | `"IfNotPresent"` | If defined, a imagePullPolicy applied to all deployments |
| images.rcloudBase.name | string | `"rcloud-base"` |  |
| images.rcloudBase.repository | string | `"registry.dev.rafay-edge.net/akshay196/rcloud-base"` | rcloud base image |
| images.rcloudBase.tag | string | `""` |  |
| images.rcloudBaseInit.name | string | `"rcloud-base-init"` |  |
| images.rcloudBaseInit.repository | string | `"registry.dev.rafay-edge.net/akshay196-temp/rcloud-base-init"` | rcloud base initialize image |
| images.rcloudBaseInit.tag | string | `""` |  |
| images.rcloudConsoleUI.name | string | `"rcloud-console-ui"` |  |
| images.rcloudConsoleUI.repository | string | `"registry.dev.rafay-edge.net/akshay196-temp/rcloud-console-ui"` | rcloud console ui image |
| images.rcloudConsoleUI.tag | string | `""` |  |
| images.relay.name | string | `"relay"` |  |
| images.relay.repository | string | `"registry.dev.rafay-edge.net/akshay196/relay"` | relay image |
| images.relay.tag | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.consoleSubdomain | string | `"console"` | subdomain used to display console UI |
| ingress.coreConnectorSubdomain | string | `"*.core-connector"` | a wildcard subdomain used for relay connection from target clusters |
| ingress.enabled | bool | `true` |  |
| ingress.host | string | `"rafay.local"` | Host |
| ingress.tls | list | `[]` | Ingress TLS for console |
| ingress.userSubdomain | string | `"*.user"` | a wildcard subdomain used for relay connection from end user |
| kratos | object | kratos subchart overwrite | the chart will overwrite some values of kratos subchart. |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` | Annotations for the all deployed pods |
| podSecurityContext | object | `{}` |  |
| postgresql.auth | object | `{"database":"admindb","enablePostgresUser":false,"existingSecret":"rcloud-postgresql","password":"admindbpassword","username":"admindbuser"}` | When `deploy.postgresql.enable` is true postgres instance is created with this credentials. |
| postgresql.dbAddr | string | `""` |  |
| rcloudBase.automigrnate | bool | `true` | Enable rcloud-base migrations |
| rcloudBase.initialize.adminEmail | string | `"foo@example.com"` | Admin email address |
| rcloudBase.initialize.adminFirstName | string | `"Foo"` | Admin first name |
| rcloudBase.initialize.adminLastName | string | `"Bar"` | Admin last name |
| rcloudBase.initialize.org | string | `"exampleorg"` | Initial organization name |
| rcloudBase.initialize.orgDesc | string | `"Org description"` | Initial organization description |
| rcloudBase.initialize.partner | string | `"example"` | Initial partner name |
| rcloudBase.initialize.partnerDesc | string | `"Partner description"` | Initial partner description |
| rcloudBase.initialize.partnerHost | string | `"example.com"` | Initial partner host |
| replicaCount | int | `1` | Number of replicas in deployment |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| services.prompt | object | `{"ports":[{"containerPort":7009,"name":"http"}],"type":"ClusterIP"}` | prompt service config |
| services.rcloudBase | object | `{"ports":[{"containerPort":11000,"name":"http"},{"containerPort":10000,"name":"rpc"},{"containerPort":10001,"name":"relay-peering"}],"type":"ClusterIP"}` | rcloud base service config |
| services.rcloudConsoleUI | object | `{"ports":[{"containerPort":80,"name":"nginx"}],"type":"ClusterIP"}` | rcloud console service config |
| services.relay | object | `{"ports":[{"containerPort":443,"name":"https"}],"type":"ClusterIP"}` | relay service config |
| tolerations | list | `[]` |  |

