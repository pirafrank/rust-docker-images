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

Two Docker images per each relevant glibc version are provided, one with current stable version of the Rust toolchain and one with `nightly`. Both are installed via the `rustup` toolchain manager at build time.

Images are built for `linux/amd64` architecture and provided under the `ghcr.io/pirafrank/rust` name.

Their tag scheme is `[STABLE RUST VERSION|nightly]-[DISTRO NAME]-glibc[GLIBC_VERSION]-[BUILD_DATE|latest]`. For example, to get Rust `1.87.0` stable and glibc `2.23`:

```txt
docker pull ghcr.io/pirafrank/rust:1.87.0-ubuntu16.04-glibc2.23-latest
```

For a full list of available images, see [GitHub Packages](https://github.com/pirafrank/rust-docker-images/pkgs/container/rust).

### Currently available tags

| GLIBC Version | Tag                                         |
|--------------|---------------------------------------------|
| 2.17         | 1.87.0-centos7-glibc2.17-latest             |
| 2.19         | 1.87.0-ubuntu14.04-glibc2.19-latest         |
| 2.23         | 1.87.0-ubuntu16.04-glibc2.23-latest         |
| 2.25         | 1.87.0-fedora26-glibc2.25-latest            |
| 2.26         | 1.87.0-fedora27-glibc2.26-latest            |
| 2.27         | 1.87.0-ubuntu18.04-glibc2.27-latest         |
| 2.28         | 1.87.0-fedora29-glibc2.28-latest            |
| 2.31         | 1.87.0-ubuntu20.04-glibc2.31-latest         |
| 2.34         | 1.87.0-fedora35-glibc2.34-latest            |
| 2.35         | 1.87.0-ubuntu22.04-glibc2.35-latest         |
| 2.36         | 1.87.0-fedora37-glibc2.36-latest            |
| 2.37         | 1.87.0-fedora38-glibc2.37-latest            |
| 2.39         | 1.87.0-ubuntu24.04-glibc2.39-latest         |
| 2.17         | nightly-centos7-glibc2.17-latest             |
| 2.19         | nightly-ubuntu14.04-glibc2.19-latest         |
| 2.23         | nightly-ubuntu16.04-glibc2.23-latest         |
| 2.25         | nightly-fedora26-glibc2.25-latest            |
| 2.26         | nightly-fedora27-glibc2.26-latest            |
| 2.27         | nightly-ubuntu18.04-glibc2.27-latest         |
| 2.28         | nightly-fedora29-glibc2.28-latest            |
| 2.31         | nightly-ubuntu20.04-glibc2.31-latest         |
| 2.34         | nightly-fedora35-glibc2.34-latest            |
| 2.35         | nightly-ubuntu22.04-glibc2.35-latest         |
| 2.36         | nightly-fedora37-glibc2.36-latest            |
| 2.37         | nightly-fedora38-glibc2.37-latest            |
| 2.39         | nightly-ubuntu24.04-glibc2.39-latest         |

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.txt) file for details.

## Guarantee

Provided as-is, without any guarantees or warranties. Use at your own risk. The maintainers are not responsible for any issues arising from the use of these images, including but not limited to compatibility problems, security vulnerabilities, or build failures.
