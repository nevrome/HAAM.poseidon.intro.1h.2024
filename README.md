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

2. Inspect the Poseidon package with standard command line tools

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

3. Use Poseidon's software tools to inspect the package

```bash
# trident's command line documentation
trident
trident list
# the list subcommand for local packages
trident list -d day3_pkg/ --packages
trident list -d day3_pkg/ --packages
trident list -d day3_pkg/ --individuals | head
# the summarise subcommand
trident summarise -d .
# the survey subcommand
trident survey -d .
```

Note that this package is compiled from the Poseidon aadr-archive, which mirrors the AADR dataset and has some special properties. The AADR .anno columns don't map perfectly to the Poseidon .janno columns.


