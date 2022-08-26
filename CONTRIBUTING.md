We 💚 Opensource!

Yes, because we feel that it’s the best way to build and improve a product. It allows people like you from across the globe to contribute and improve a product over time. And we’re super happy to see that you’d like to contribute to Paralus.

We are always on the lookout for anything that can improve the product. Be it feature requests, issues/bugs, code or content, we’d love to see what you’ve got to make this better. If you’ve got anything exciting and would love to contribute, this is the right place to begin your journey as a contributor to Paralus and the larger open source community.

## How to get started?

The easiest way to start is to look at existing issues and see if there’s something there that you’d like to work on. You can filter issues with the label “[Good first issue](https://github.com/paralus/helm-charts/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)” which are relatively self sufficient issues and great for first time contributors.

Once you decide on an issue, please comment on it so that all of us know that you’re on it.

If you’re looking to add a new feature, [raise a new issue](https://github.com/paralus/helm-charts/issues/new) and start a discussion with the community. Engage with the maintainers of the project and work your way through.

You'll need to perform the following tasks in order to submit your changes:

- Fork the paralus/helm-charts repository.
- Create a branch for your changes.
- Add commits to that branch.
- Open a PR to share your contribution.

Below are all the details you need to know and get started with the development.

# Paralus helm-charts

This repo hosts the helm charts that is used to deploy `paralus` to any kubernetes cluster.

## Development setup

### Installing and Configuring Kind

If you don't already have Kind installed on your local system, you can do so by following the [Kind Quickstart Documentation](https://kind.sigs.k8s.io/docs/user/quick-start/). The default settings are good enough to get you started.

The next step is to **create a Kind cluster**. To do that you can create a copy of [this configuration file](https://github.com/paralus/helm-charts/blob/main/docs/kind.config.yaml) and use that to create a cluster.

```bash
kind create cluster --config cluster.yaml
```

*You can optionally pass name via `--name <name>` to create a kind cluster with a specific name.*

### Install Paralus from helm chart source

You can install the helm chart from source using the following command once you have cloned the repo.

``` bash
# helm install -n <namesapce> <installation_name> ./charts/ztka --values <custom_values_file> --create-namespace
helm install -n ztka ztka ./charts/ztka --values examples/values.dev-generic.yaml --create-namespace
```

You should now have `paralus` deployed. You can check out our blog post to [setup Paralus on Kind](https://www.paralus.io/blog/kind-quickstart) for a detailed guide on how to set up the rest of the application.

From here you should be able to edit the files and repeat these steps to test it out.

## Documentation

The documentation for each chart is done with [helm-docs](https://github.com/norwoodj/helm-docs). This way we can ensure that values are consistent with the chart documentation.

Run the following command to regenerate the docs. Make sure to run this before you submit a pull request.

``` shell
helm-docs --chart-search-root=charts
```

## Need Help?

If you are interested to contribute to helm-charts but are stuck with any of the steps, feel free to reach out to us. Please [create an issue](https://github.com/paralus/helm-charts/issues/new) in this repository describing your issue and we'll take it up from there.

You can reach out to us via our [Slack Channel](https://join.slack.com/t/paralus/shared_invite/zt-1a9x6y729-ySmAq~I3tjclEG7nDoXB0A) or [Twitter](https://twitter.com/paralus_).
