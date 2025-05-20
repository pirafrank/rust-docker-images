# Glibc across Linux distributions

> [!IMPORTANT]
> Rust requires glibc 2.17 or above as per https://blog.rust-lang.org/2022/08/01/Increasing-glibc-kernel-requirements/.

Rust requires glibc 2.17 or above, which means it supports major Linux distributions released in the **last 10 years** for `unknown-linux-gnu` targets.

If you are using an even older version of a distribution, you may want to go for a musl build of your application, which is statically linked and does not depend on glibc.

## Checking glibc version

You can check the glibc version of your distro or Docker image by running:

```sh
ldd --version
```

You can also check the minimum glibc version required by a compiled Rust binary using this one-liner:

```bash
readelf -d <your-binary> | \
grep -oP '\(GLIBC[^)]*\)' | \
grep -oE '[0-9]{1,}\.[0-9]{1,}(\.[0-9]{1,})?' \
| sort | uniq | sort -rV | head -n1
```

where `<your-binary>` is the path to your compiled Rust binary.

## glibc versions across major Linux distributions

### Ubuntu

| Release Version | Codename        | Release Date | glibc Version |
| --------------- | --------------- | ------------ | ------------- |
| 14.04 LTS       | Trusty Tahr     | Apr 2014     | 2.19          |
| 16.04 LTS       | Xenial Xerus    | Apr 2016     | 2.23          |
| 18.04 LTS       | Bionic Beaver   | Apr 2018     | 2.27          |
| 20.04 LTS       | Focal Fossa     | Apr 2020     | 2.31          |
| 22.04 LTS       | Jammy Jellyfish | Apr 2022     | 2.35          |
| 23.10           | Mantic Minotaur | Oct 2023     | 2.38          |
| 24.04 LTS       | Noble Numbat    | Apr 2024     | 2.39          |
| 24.10           | Oracular Oriole | Oct 2024     | 2.39          |

### Debian

| Release Version | Codename         | Release Date  | glibc Version |
| --------------- | ---------------- | ------------- | ------------- |
| 8               | Jessie           | Apr 2015      | 2.19          |
| 9               | Stretch          | Jun 2017      | 2.24          |
| 10              | Buster           | Jul 2019      | 2.28          |
| 11              | Bullseye         | Aug 2021      | 2.31          |
| 12              | Bookworm         | Jun 2023      | 2.36          |
| 13              | Trixie (Testing) | Expected 2025 | 2.41          |

### CentOS / RHEL

| Release Version | Release Date | glibc Version |
| --------------- | ------------ | ------------- |
| 7               | Jun 2014     | 2.17          |
| 8               | May 2019     | 2.28          |
| 9               | Dec 2021     | 2.34          |
| Stream 10       | Dec 2024     | 2.37          |

### Arch Linux

| Release Version | Release Date | glibc Version |
| --------------- | ------------ | ------------- |
| Rolling         | Rolling      | 2.40          |

### Fedora

| Release Version | Release Date | glibc Version |
| --------------- | ------------ | ------------- |
| 20              | Dec 2013     | 2.18          |
| 21              | Dec 2014     | 2.20          |
| 22              | May 2015     | 2.21          |
| 23              | Nov 2015     | 2.22          |
| 24              | Jun 2016     | 2.23          |
| 25              | Nov 2016     | 2.24          |
| 26              | Jul 2017     | 2.25          |
| 27              | Nov 2017     | 2.26          |
| 28              | May 2018     | 2.27          |
| 29              | Oct 2018     | 2.28          |
| 30              | Apr 2019     | 2.29          |
| 31              | Oct 2019     | 2.30          |
| 32              | May 2020     | 2.31          |
| 33              | Oct 2020     | 2.32          |
| 34              | May 2021     | 2.33          |
| 35              | Nov 2021     | 2.34          |
| 36              | May 2022     | 2.35          |
| 37              | Nov 2022     | 2.36          |
| 38              | May 2023     | 2.37          |
| 39              | Nov 2023     | 2.38          |
| 40              | May 2024     | 2.39          |
| 41              | Nov 2024     | 2.40          |
| 42              | May 2025     | 2.41          |
