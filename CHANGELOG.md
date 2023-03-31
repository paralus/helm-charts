# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

## [0.2.3] - 2023-03-31

### Changed
- Update kratos chart to kratos app version 0.11.1 from [akshay196](https://github.com/akshay196)
- Added set-limits init container for relay server to increase ulimit from [niravparikh05](https://github.com/niravparikh05)
- Updated image versions for paralus, dashboard, relay from [niravparikh05](https://github.com/niravparikh05)

## [0.2.2] - 2023-02-24

### Changed
- Updated image versions for paralus, dashboard, relay from [niravparikh05](https://github.com/niravparikh05)

## [0.2.1] - 2023-01-27

### Changed
- Upgraded kratos version and changes for default password feature [akshay196](https://github.com/akshay196)

## [0.2.0] - 2022-12-29

### Added
- Updated kratos with after_login webhook to record event into paralus from [mabhi](https://github.com/mabhi)

### Changed
- Updated bitnami chart repository for postgres and contour [niravparikh05](https://github.com/niravparikh05)

## [0.1.9] - 2022-11-25

### Added
- Support database as a auditlog storage from [vivekhiwarkar](https://github.com/vivekhiwarkar) and [akshay196](https://github.com/akshay196)

## [0.1.8] - 2022-11-04

### Changed
- Restart the paralus pod after helm upgrade from [akshay196](https://github.com/akshay196)

### Fixed
- Fixed the NOTES.txt for helm upgrade from [akshay196](https://github.com/akshay196)

## [0.1.7] - 2022-10-14
### Changed
- Updated image versions for paralus, dashboard from [niravparikh05](https://github.com/niravparikh05)

## [0.1.6] - 2022-10-10
### Changed
- Updated default partner, organization name and image versions for paralus, dashboard from [niravparikh05](https://github.com/niravparikh05)

## [0.1.5] - 2022-09-30
### Changed
- Updated image versions for relay, paralus, dashboard from [meain](https://github.com/meain)

## [0.1.4] - 2022-09-20
### Changed
- Automatically cleanup kratos restart job pods on success from [meain](https://github.com/meain)

## [0.1.3] - 2022-08-26
### Changed
- Bumped paralus/paralus to 0.1.3 from [niravparikh05](https://github.com/niravparikh05)
- Bumped paralus/relay to 0.1.1 from [niravparikh05](https://github.com/niravparikh05)
- Bumped paralus/prompt to 0.1.1 from [niravparikh05](https://github.com/niravparikh05)

## [0.1.2] - 2022-08-12
### Changed
- Bumped paralus/paralus to 0.1.2 from [meain](https://github.com/meain)

## [0.1.1] - 2022-08-09
### Added
- Helm upgrade & rollback hook to restart Kratos from [akshay196](https://github.com/akshay196)
### Changed
- Allow explicit setting of postgresql DSN from [mcfearsome](https://github.com/mcfearsome) and [meain](https://github.com/meain)

### Fixed
- Prevent filebeat from fetching application logs for audit from [meain](https://github.com/meain)
- Fixed typo in output of postgresql Password from [mcfearsome](https://github.com/mcfearsome)

## [0.1.0] - 2022-06-22
### Added
- Initial release

[Unreleased]: https://github.com/paralus/helm-charts/compare/ztka-0.2.2...HEAD
[0.2.2]: https://github.com/paralus/helm-charts/compare/ztka-0.2.1...ztka-0.2.2
[0.2.1]: https://github.com/paralus/helm-charts/compare/ztka-0.2.0...ztka-0.2.1
[0.2.0]: https://github.com/paralus/helm-charts/compare/ztka-0.1.9...ztka-0.2.0
[0.1.9]: https://github.com/paralus/helm-charts/compare/ztka-0.1.8...ztka-0.1.9
[0.1.8]: https://github.com/paralus/helm-charts/compare/ztka-0.1.7...ztka-0.1.8
[0.1.7]: https://github.com/paralus/helm-charts/compare/ztka-0.1.6...ztka-0.1.7
[0.1.6]: https://github.com/paralus/helm-charts/compare/ztka-0.1.5...ztka-0.1.6
[0.1.5]: https://github.com/paralus/helm-charts/compare/ztka-0.1.4...ztka-0.1.5
[0.1.4]: https://github.com/paralus/helm-charts/compare/ztka-0.1.3...ztka-0.1.4
[0.1.3]: https://github.com/paralus/helm-charts/compare/ztka-0.1.2...ztka-0.1.3
[0.1.2]: https://github.com/paralus/helm-charts/compare/ztka-0.1.1...ztka-0.1.2
[0.1.1]: https://github.com/paralus/helm-charts/compare/ztka-0.1.0...ztka-0.1.1
[0.1.0]: https://github.com/paralus/helm-charts/releases/tag/ztka-0.1.0
