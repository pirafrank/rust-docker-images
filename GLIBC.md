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

## glibc major changes for Rust developers

Bellow a list of glibc versions since 2.17 that introduced significant changes or compatibility shifts meaninful for Rust developers compiling towards `--gnu` targets.

The focus is on compatibility, dynamic linking behavior, system call availability, and features affecting build reproducibility or minimum supported glibc versions for distributing Rust binaries.


### glibc 2.17 (Dec 2012)

- Baseline for many enterprise systems (e.g., RHEL 7).
- Often chosen as the lowest common denominator for prebuilt Rust binaries targeting GNU.
- Introduced support for `getrandom()` via syscall, used in Rust via `rand` or `getrandom` crates (though not exposed in glibc until 2.25).


### glibc 2.25 (Feb 2017)

- `clock_gettime()` and others no longer require linking to `-lrt`.
  - Rust crates using `std::time::Instant`, `std::thread::sleep`, etc., indirectly benefit.
- Introduced `getrandom()` wrapper—previously, Rust had to use direct syscalls on Linux.


### glibc 2.26 (Aug 2017)

- Improved thread scalability via scalable `malloc`.
- Added `explicit_bzero()` – useful for crates handling cryptographic zeroing (adopted in `zeroize`).


### glibc 2.27 (Feb 2018)

- Further optimized `malloc` and TLS behavior.
- Default in Ubuntu 18.04 LTS, common in CI environments.


### glibc 2.28 (Aug 2018)

- Added `gettid()` and `statx()` wrappers (used in some logging/debugging crates and performance tools).


### glibc 2.31 (Feb 2020)

- Enabled security hardening flags and stack protection by default—relevant if linking Rust with `cc`-built C code.
- Improved performance for `memcpy`, `memset`—impacts `Vec`, `Box`, and other heap-using types.


### glibc 2.34 (Aug 2021)

- Major milestone: Unified `libpthread`, `librt`, `libdl`, and `libresolv` into `libc.so.6`.
  - Reduces dynamic linker complexity and dependency footprint.
  - Rust static builds benefit due to simplified dynamic symbol resolution.
- Introduced support for `close_range()` syscall—used in modern sandboxing crates and runtime environments.


### glibc 2.36 (Aug 2022)

- Removed support for `LD_PREFER_MAP_32BIT_EXEC`, strengthening ASLR and making builds more secure by default.
- Added wrappers for new syscalls (e.g., `futex2`) used in async runtimes (`tokio`, `smol`) via FFI.

### glibc 2.37 (Feb 2023)

- Expanded support for additional targets (like `loongarch`).
- Continued enhancements in dynamic linker, locale, and ABI compatibility—all of which reduce friction when building and distributing Rust software on mixed-libc environments.

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
