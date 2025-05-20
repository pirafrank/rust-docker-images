# Docker images for Rust

This project aims to deliver Docker images specifically engineered for building Rust applications with a deterministic `glibc` version.

## Motivation

Rust binaries targeting `*-unknown-linux-gnu` are dynamically linked to the glibc version present in the build environment, which sets the minimum glibc requirement for running the resulting binary.

This can be problematic when using modern build hosts—such as GitHub Actions runners based on Ubuntu 22.04 or 24.04 since these environments ship with recent glibc versions (e.g., `2.35+`), potentially making the binaries incompatible with older or LTS Linux distributions still in widespread use. While musl (statically linked) builds are an option, they may not be suitable for all applications, especially those relying on glibc-specific features or libraries.

By building Rust applications inside these Docker images, developers can control the glibc version used during compilation, ensuring that the produced Rust binaries are compatible with a broader range of Linux systems, including those with older glibc releases.

## Use cases

Typical use cases are CI/CD scenarios (e.g., GitHub Actions, GitLab CI), e.g.:

- Building Rust binaries in CI pipelines (such as GitHub Actions) where the underlying runner OS cannot be changed and the host OS glibc version is too new for your target audience
- Producing portable CLI tools or services intended for distribution across different Linux environments
- Ensuring consistent build outputs regardless of developer workstation or CI runner configuration
- Testing Rust applications against multiple glibc versions to validate compatibility

## GLIBC versions

Check the [GLIBC.md](GLIBC.md) file for a list of glibc versions used in major Linux distributions.

## Images

Images use stable and nightly versions of Rust configured via the `rustup` toolchain manager.

For a list of available images, see [GitHub Packages](https://github.com/pirafrank/rust-docker-images/pkgs/container/rust).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.txt) file for details.

## Guarantee

Provided as-is, without any guarantees or warranties. Use at your own risk. The maintainers are not responsible for any issues arising from the use of these images, including but not limited to compatibility problems, security vulnerabilities, or build failures.
