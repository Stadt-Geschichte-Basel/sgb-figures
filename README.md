# sgb-figures

This repository contains code and data for creating plots used in the [Stadt.Geschichte.Basel](https://stadtgeschichtebasel.ch) research project. The data in this repository is openly available to everyone and is intended to support reproducible research.

[![GitHub issues](https://img.shields.io/github/issues/Stadt-Geschichte-Basel/sgb-figures.svg)](https://github.com/Stadt-Geschichte-Basel/sgb-figures/issues)
[![GitHub forks](https://img.shields.io/github/forks/Stadt-Geschichte-Basel/sgb-figures.svg)](https://github.com/Stadt-Geschichte-Basel/sgb-figures/network)
[![GitHub stars](https://img.shields.io/github/stars/Stadt-Geschichte-Basel/sgb-figures.svg)](https://github.com/Stadt-Geschichte-Basel/sgb-figures/stargazers)
[![Code license](https://img.shields.io/badge/Code-AGPL--3.0-orange)](LICENSE-AGPL.md)
[![Plot license](https://img.shields.io/badge/Plots-CC_BY--SA_4.0-green)](LICENSE-CCBY.md)

<!-- [![DOI](https://zenodo.org/badge/949870855.svg)](https://zenodo.org/badge/latestdoi/ZENODO_RECORD) -->

## Repository Structure

The structure of this repository follows the [Advanced Structure for Data Analysis](https://the-turing-way.netlify.app/project-design/project-repo/project-repo-advanced.html) from _The Turing Way_ and is organized as follows:

- `build/`: scripts and notebooks used to build the data
- `data/`: data files
- `docs/`: documentation for the data and the repository
- `output/`: generated PDF files
- `src/`: source code for the data (e.g., scripts used to collect or process the data)

## Data Description

This repository stores data and R code used by the [Team for Research Data Management and Public History](https://dokumentation.stadtgeschichtebasel.ch/team.html) of the Stadt.Geschichte.Basel research project to create figures published in the [nine-volume book series](https://stadtgeschichtebasel.ch/baende).

One task of the Stadt.Geschichte.Basel RDM team is to provide visualisations for data used by the individual authors to support their arguments. Using raw data provided by the researchers, the RDM team created maps, diagrams, and other types of visualisations for publication in the [print](https://www.merianverlag.ch/buecher/stadt.geschichte.basel.html) and [online (OA)](https://emono.unibas.ch/stadtgeschichtebasel) versions of Stadt.Geschichte.Basel.

To support open research with FAIR data, the RDM team developed a [research data platform](https://forschung.stadtgeschichtebasel.ch) to ensure open, long-term access to sources and research data regarding the history of Basel. The platform facilitates access to the data behind the publication, with metadata annotation following the [Manual for Creating Non-Discriminatory Metadata for Historical Sources and Research Data](https://maehr.github.io/diskriminierungsfreie-metadaten/) developed by Stadt.Geschichte.Basel.

### Data Model

The repository uses a structured approach to manage its data. Each dataset is associated with a specific plot and is accompanied by a detailed metadata file. Here's a breakdown of the data model based on the files in the repository:

- **Data Storage**: The data is stored in CSV format. Each plot or figure has its own corresponding data file. These files are organized into directories based on the volume and figure number from the "Stadt.Geschichte.Basel" book series. For example, `data/clean/Band2/34278/34278_Data.csv`.

- **Metadata**: Each CSV file is paired with a JSON metadata file that conforms to the [W3C CSV on the Web (CSVW)](https://www.w3.org/ns/csvw) standard. This file describes the schema of the CSV file, including column names, data types, and descriptions, as well as providing rich contextual metadata about the dataset.

- **Example Schema**: Let's look at the schema for `39017_Data.csv`, which is about Ludwig Kilchmann's annuity business. The data contains the following columns:
  - `Jahr`: The year (numeric).
  - `Summe Ablösungen`: The total sum of redeemed annuities in that year, in Gulden (numeric).
  - `Summe Neueinträge`: The total sum of new annuities in that year, in Gulden (numeric).
  - `Investierte Summe netto`: The net invested sum in annuities for that year, in Gulden (numeric).

This structured approach with CSV and CSVW files makes the data FAIR (Findable, Accessible, Interoperable, and Reusable).

### Plots

This GitHub repository provides the source code used to create [all plots](/docs/plots.qmd) used in the project. In addition to the data already made available on the research data platform, the source code published here makes the figures even more customisable.

Following the steps below, users can build plots from the book series by themselves. The workflow produces the plots, as published, as `PDF` files in `CMYK` colour mode using the dimensions from the printed volumes. For technical reasons, plots and legends are written to separate PDF files. The plots are not shipped with the project's signature font family, but are generated with a generic system font due to copyright. Users can easily customise the plots' dimensions, colours, labels, etc. by changing the parameters in the corresponding source code.

The (mostly numerical) data behind the plots, also available in interactive tables on the research data platform, is additionally stored in this repository in `CSV` format. For each dataset, a `JSON` file is generated, providing metadata according to the [W3C standard for tabular data and metadata on the web](https://w3c.github.io/csvw/syntax/).

```{mermaid}
graph TD
    subgraph User Interaction
        A[User runs 'npm run plot <ID>']
    end

    subgraph Build Process
        B{plot_pipeline.R}
        C{Finds R script in 'src/<ID>/'}
        D[Executes '<ID>_plot.R']
    end

    subgraph Data and Source
        E[Reads data from 'data/clean/<Band>/<ID>/']
        F[Generates plot using ggplot2 and other R packages]
    end

    subgraph Output
        G[Saves plot as PDF in 'output/']
    end

    A --> B;
    B --> C;
    C --> D;
    D --> E;
    D --> F;
    F --> G;
```

### Software

All plots are produced using [R](https://www.r-project.org/). The R environment including all necessary packages can be restored with the `renv.lock` file. In addition to [ggplot2](https://ggplot2.tidyverse.org/) and other parts of the [tidyverse](https://www.tidyverse.org/), this project uses several packages for data processing and visualisation, including [here](https://here.r-lib.org/index.html) and [renv](https://rstudio.github.io/renv/index.html) for creating a reproducible environment as well as [csvwr](https://cloud.r-project.org/web/packages/csvwr/index.html) for writing metadata files.

## Installation

Install Node.js, Quarto and R. Run the following commands in the root directory of the repository:

```bash
npm install
```

Set up the R environment using renv:

```bash
npm run setup
```

## Build

Print a list of all plots that can be built from this repository:

```bash
npm run list
```

Build an individual plot as PDF — saving the plot to `output/`, the annotated data to `data/clean/`, and a summary Quarto file to `docs/plots` — by running the following command:

```bash
npm run plot
```

Specify the ID of the plot when prompted, e.g.:

```text
Bitte ID des Plots eingeben (z.B. 39017 für abb39017): 39017
```

You can also specify the plot directly:

```bash
npm run plot 39017
```

Build all plots from a specific volume, e.g., volume 7:

```bash
npm run vol 7
```

Build all plots that are available in this repository:

```bash
npm run all
```

Format all R scripts using `styler` and `lintr`:

```bash
npm run format:r
```

## Usage

These data are openly available to everyone and can be used for any research or educational purpose. If you use this data in your research, please cite as specified in [CITATION.cff](CITATION.cff). <!-- The following citation formats are also available through _Zenodo_: -->

<!--
- [BibTeX](https://zenodo.org/record/ZENODO_RECORD/export/hx)
- [CSL](https://zenodo.org/record/ZENODO_RECORD/export/csl)
- [DataCite](https://zenodo.org/record/ZENODO_RECORD/export/dcite4)
- [Dublin Core](https://zenodo.org/record/ZENODO_RECORD/export/xd)
- [DCAT](https://zenodo.org/record/ZENODO_RECORD/export/dcat)
- [JSON](https://zenodo.org/record/ZENODO_RECORD/export/json)
- [JSON-LD](https://zenodo.org/record/ZENODO_RECORD/export/schemaorg_jsonld)
- [GeoJSON](https://zenodo.org/record/ZENODO_RECORD/export/geojson)
- [MARCXML](https://zenodo.org/record/ZENODO_RECORD/export/xm)

_Zenodo_ provides an [API (REST & OAI-PMH)](https://developers.zenodo.org/) to access the data. For example, the following command will return the metadata for the most recent version of the data

```bash
curl -i https://zenodo.org/api/records/ZENODO_RECORD
```
-->

## Support

This project is maintained by [@Stadt-Geschichte-Basel](https://github.com/stadt-geschichte-basel). Please understand that we can't provide individual support via email. We also believe that help is much more valuable when it's shared publicly, so more people can benefit from it.

| Type                                   | Platforms                                                                               |
| -------------------------------------- | --------------------------------------------------------------------------------------- |
| 🚨 **Bug Reports**                     | [GitHub Issue Tracker](https://github.com/stadt-geschichte-basel/sgb-figures/issues)    |
| 📊 **Report bad data**                 | [GitHub Issue Tracker](https://github.com/stadt-geschichte-basel/sgb-figures/issues)    |
| 📚 **Docs Issue**                      | [GitHub Issue Tracker](https://github.com/stadt-geschichte-basel/sgb-figures/issues)    |
| 🎁 **Feature Requests**                | [GitHub Issue Tracker](https://github.com/stadt-geschichte-basel/sgb-figures/issues)    |
| 🛡 **Report a security vulnerability** | See [SECURITY.md](SECURITY.md)                                                          |
| 💬 **General Questions**               | [GitHub Discussions](https://github.com/stadt-geschichte-basel/sgb-figures/discussions) |

## Roadmap

- [] Archive repository on Zenodo
- [] Add DOIs
- [] Add alt-text to plots

## Contributing

All contributions to this repository are welcome! If you find errors or problems with the data, or if you want to add new data or features, please open an issue or pull request. Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## Versioning

We use [SemVer](http://semver.org/) for versioning. The available versions are listed in the [tags on this repository](https://github.com/stadt-geschichte-basel/sgb-figures/tags).

## Authors and Acknowledgments

- **Moritz Twente** -- _Initial work_ -- [mtwente](https://github.com/mtwente)

See also the list of [contributors](https://github.com/stadt-geschichte-basel/sgb-figures/graphs/contributors) who contributed to this project.

## License

This codebase is released under the GNU Affero General Public License v3.0. See the [LICENSE-AGPL](LICENSE-AGPL.md) file for details. By using this code, you agree to make any modifications available under the same license.

The output of the code in this repository is released under the Creative Commons Attribution 4.0 International (CC BY 4.0) License — see the [LICENSE-CCBY](LICENSE-CCBY.md) file for details. By using this data, you agree to give appropriate credit to the original author(s) and to indicate if any modifications have been made.

The tabular data in this repository, specifically in `data/`, is released according to the individual licensing as stated in the respective metadata files.
