# HAAM.poseidon.intro.1h.2024

## Context

This session was prepared for the [HAAM Summer School 2024](https://haam-community.github.io/haam-summer-school). It includes a small introduction to the [Poseidon framework for ancient human genotype data management](https://www.poseidon-adna.org/).

A script to prepare the starting data for this session is available in this repository [here](https://github.com/nevrome/HAAM.poseidon.intro.1h.2024/blob/main/prepare_data.R).

The participants of the session have access to a pre-configured virtual machine with the relevant software tools installed and the starting data readily available at `/vol/volume/poseidon/day3_pkg`.

## Tutorial

The following steps introduce some of the core features of the Poseidon software tools.

> [!NOTE] 
> We will not produce any new data relevant for later sessions of the summer school. It is not critical if you can not follow along.

> [!CAUTION]
> Editing the data in `/vol/volume/poseidon/day3_pkg` may render the data unsuitable for later sessions. Please be careful with this data.

### Exploring a single Poseidon package

1. Move to `/vol/volume/poseidon` on the command line.

```bash
cd /vol/volume/poseidon/
```

2. Inspect a Poseidon package with standard command line tools

```bash
# the package files
ls day3_pkg
du -sch day3_pkg/*
# the POSEIDON.yml file
cat day3_pkg/POSEIDON.yml
# the genotype data, e.g. the .fam file
less day3_pkg/day3.fam
wc -l day3_pkg/day3.fam
# the .bib and .janno files
less day3_pkg/day3.bib
less day3_pkg/day3.janno
```

3. Use `trident` to inspect the package

```bash
# trident's command line documentation
trident
trident list
# the list subcommand for local packages
trident list -d day3_pkg --packages
trident list -d day3_pkg --packages
trident list -d day3_pkg --individuals | head
# the summarise subcommand
trident summarise -d day3_pkg
# the survey subcommand
trident survey -d day3_pkg
```

Note that this package is compiled from the Poseidon aadr-archive, which mirrors the AADR dataset and has some special properties. The AADR .anno columns don't map perfectly to the Poseidon .janno columns.

### Creating a package as a subset of another one

1. Create a scratch directory for experiments

```bash
mkdir scratch
```

2. Create a new package with `trident forge`

```bash
# command line documentation
trident forge
# the forge subcommand
trident forge -d day3_pkg -f "Mbuti.HO, Russia_Samara_EBA_Yamnaya" -o scratch/aadr_subset
```

This runs for about 1 min.

3. Inspect the result

```bash
cd scratch
ls aadr_subset
trident list -d aadr_subset --individuals
```

4. Validate and modify the package

```bash
# the validate subcommand
trident validate -d aadr_subset
# add the missing contributor field
nano aadr_subset/POSEIDON.yml
```

```
contributor:
  - name: Clemens Schmid
    email: clemens_schmid@eva.mpg.de
```

```bash
trident validate -d aadr_subset
```

### Downloading data from the public Poseidon archives

1. Exploring data available on the server

```bash
# using list with the Poseidon server
trident list
trident list --remote --packages
# different archives
trident list --remote --packages --archive community-archive
trident list --remote --packages --archive aadr-archive
# individual information with .janno fields
trident list --remote --individuals
trident list --remote --individuals -j Country
```

We also built a little website to browse this data directly: https://www.poseidon-adna.org/#/archive_explorer

2. Downloading packages from the server

```bash
# the fetch subcommand
trident fetch
trident fetch -d . -f "<Iceman.SG>,Austria_EN_LBK,Croatia_Mesolithic_HG"
ls
trident list -d . --packages
```

`fetch` always downloads all packages that contain any entity in the `-f` argument.

