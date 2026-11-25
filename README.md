<h1 align="center">MRtrix3 Anatomically Constrained Tractography (RACE-Track)</h1>

<p align="center">
  A whole-brain tractogram from preprocessed diffusion MRI and a T1-weighted image, using MRtrix3 anatomically constrained tractography (ACT) and ensemble tracking.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.319"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.319-blue.svg" alt="Run on brainlife.io"></a>
  <a href="https://github.com/brainlife/app-mrtrix3-act/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

> **This branch, `1.4`, runs 3 brainlife.io Apps** that share the same code:
>
> - mrtrix3 - WMC Anatomically Constrained Tractography (ACT) ([doi:10.25663/brainlife.app.319](https://doi.org/10.25663/brainlife.app.319))
> - Whole Brain Tractography ([doi:10.25663/brainlife.app.318](https://doi.org/10.25663/brainlife.app.318)) (deprecated)
> - RACE-Track | MRTrix3 Anatomical Informed Tractography ([doi:10.25663/bl.app.101](https://doi.org/10.25663/bl.app.101))
>
> The other Apps in this repository are listed under **Versions on brainlife.io** below.

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

### mrtrix3 - WMC Anatomically Constrained Tractography (ACT)

> **Generates a whole-brain tractogram with MRtrix3 anatomically constrained probabilistic (iFOD2) tractography from preprocessed DWI and a T1w image, with settings preset for white matter tract segmentation.**

Runs the same RACE-Track code as the MRtrix3 ACT App (FSL bet mask, 5ttgen fsl, tensor and CSD fits, tckgen seeded at the grey-white matter interface) but exposes only iFOD2 probabilistic tracking with defaults for tract segmentation (1.5 million streamlines, 25-220 mm, curvature 35). Use it before white matter classification Apps. Needs a preprocessed DWI and a T1w image aligned to it.

| | |
|---|---|
| **Inputs** | `neuro/dwi` · `neuro/anat/t1w` |
| **Outputs** | `neuro/track/tck` · `neuro/tensor` · `neuro/csd` |
| **Container** | `brainlife/mrtrix3:3.0_RC3` |
| **Run it** | [doi.org/10.25663/brainlife.app.319](https://doi.org/10.25663/brainlife.app.319) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `dwi` | `neuro/dwi` (preprocessed) | yes | Preprocessed DWI with bvecs and bvals. Must contain b=0 volumes; single- or multi-shell. |
| `anat` | `neuro/anat/t1w` | yes | T1-weighted image aligned to the DWI, used by 5ttgen fsl to build the five-tissue-type image for ACT. If already skull-stripped, set premask to true. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `tracking` | `neuro/track/tck` | Ensemble tractogram (track.tck) merging the streamlines from every requested algorithm, lmax and curvature. |
| `tensor` | `neuro/tensor` | Tensor-model outputs (fa, md, ad, rd, cl, cp, cs, tensor and kurtosis files). Note: in this branch the code copies fa.nii.gz into every file of this folder, so only fa is correct. |
| `csd` | `neuro/csd` | CSD fibre orientation distributions per lmax (lmaxN.nii.gz), normalised when norm is true. |

<details>
<summary><b>Parameters</b> (10)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `min_length` | string | `25` | the minimum length a streamline may be |
| `max_length` | string | `220` | the maximum length a streamline may be |
| `imaxs` | string | ` ` | This will find the maximum possible lmax within the data and use that. |
| `ens_lmax` | boolean | `false` | perform ensemble tracking on every lmax up to the maximum value passed |
| `curvs` | string | `35` | the maximum curvature angle streamline can take during tracking |
| `num_fibers` | string | `1500000` | the number of streamlines to produce |
| `do_prb2` | boolean | `true` | perform mrtrix3 probabilistic tractography |
| `premask` | boolean | `false` | If the input anatomical T1s have already been skull stripped, check this to prevent 5ttgen from cutting off a portion of the brain. (This sets -premasked option for 5ttgens) |
| `norm` | boolean | `false` | unused and unmodified intensity normalization |
| `tensor_fit` | string |  | b-value of the shell to extract for the tensor fit with multi-shell data; ignored for single-shell data, and if the b-value is absent all shells are used. |

</details>

### RACE-Track | MRTrix3 Anatomical Informed Tractography

> **Generates an ensemble whole-brain tractogram with MRtrix3 anatomically constrained tractography (ACT) from preprocessed single- or multi-shell DWI and a T1w image, combining CSD and tensor algorithms across lmax and curvature values.**

Builds a brain mask with FSL bet, a five-tissue-type image with 5ttgen fsl, fits the tensor (and kurtosis for multi-shell) and CSD or multi-shell multi-tissue CSD at each lmax, and runs tckgen with the selected algorithms (iFOD2, iFOD1, SD_STREAM, FACT, Tensor_Det, Tensor_Prob) seeded at the grey-white matter interface for every lmax and curvature; all streamlines are merged into one track.tck (RACE-Track). Use it to produce a whole-brain tractogram for tract segmentation or connectomics. Needs a preprocessed DWI and a T1w image aligned to it. Expect long runtimes for many parameter combinations.

| | |
|---|---|
| **Inputs** | `neuro/dwi` · `neuro/anat/t1w` |
| **Outputs** | `neuro/track/tck` · `neuro/tensor` · `neuro/csd` |
| **Container** | `brainlife/mrtrix3:3.0_RC3` |
| **Run it** | [doi.org/10.25663/bl.app.101](https://doi.org/10.25663/bl.app.101) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `dwi` | `neuro/dwi` (preprocessed) | yes | Preprocessed DWI with bvecs and bvals. Must contain b=0 volumes; single- or multi-shell. |
| `anat` | `neuro/anat/t1w` | yes | T1-weighted image aligned to the DWI, used by 5ttgen fsl to build the five-tissue-type image for ACT. If already skull-stripped, set premask to true. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `tracking` | `neuro/track/tck` | Ensemble tractogram (track.tck) merging the streamlines from every requested algorithm, lmax and curvature. |
| `tensor` | `neuro/tensor` | Tensor-model outputs (fa, md, ad, rd, cl, cp, cs, tensor and kurtosis files). Note: in this branch the code copies fa.nii.gz into every file of this folder, so only fa is correct. |
| `csd` | `neuro/csd` | CSD fibre orientation distributions per lmax (lmaxN.nii.gz), normalised when norm is true. |

<details>
<summary><b>Parameters</b> (17)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `tensor_fit` | string |  | If multi-shell data is passed, this selects the shell that will be extracted and have a tensor fit performed If single-shell data is passed, this is ignored |
| `norm` | boolean | `false` | perform log-domain normalization of CSD data before tracking (multi-shell data only) |
| `min_length` | string | `10` | the minimum length a streamline may be |
| `max_length` | string | `200` | the maximum length a streamline may be |
| `imaxs` | string |  | The lmax(s) or maximum value to fit and create tractography data. If not provided, the App will find the maximum possible lmax within the data and use that. |
| `ens_lmax` | boolean | `true` | perform ensemble tracking on every lmax up to the maximum value passed |
| `curvs` | string | `5 10 20 40 80` | the maximum curvature angle streamline can take during tracking |
| `num_fibers` | string | `15000` | the number of streamlines to produce per parameter combination |
| `do_dtdt` | boolean | `true` | perform tensor-based deterministic tractography |
| `do_dtpb` | boolean | `false` | perform tensor-based probabilistic tractography |
| `do_detr` | boolean | `true` | perform deterministic tractography |
| `do_prb1` | boolean | `false` | perform mrtrix2 probabilistic tractography |
| `do_prb2` | boolean | `true` | perform mrtrix3 probabilistic tractography |
| `do_fact` | boolean | `false` | Perform FACT tracking |
| `fact_dirs` | number | `3` | Number of peak directions extracted from each FOD for FACT tracking. |
| `fact_fibs` | number | `0` | Number of FACT streamlines to generate per lmax. |
| `premask` | boolean | `false` | If the input anatomical T1s have already been skull stripped, check this to prevent 5ttgen from cutting off a portion of the brain. (This sets -premasked option for 5ttgens) |

</details>

<!-- brainlife-app:end -->

## Versions on brainlife.io

This repository implements **R**eproducible **A**natomically **C**onstrained **E**nsemble **Track**ing (RACE-Track). The same code runs in several Apps; some of them fix parameters to reproduce outputs for a specific use (networks, white matter tract segmentation, and so on).

| App | MRtrix3 | Branch | Run it | Status |
|---|---|---|---|---|
| **mrtrix3 - WMC Anatomically Constrained Tractography (ACT)** (this branch) | 3.0_RC3 | [`1.4`](https://github.com/brainlife/app-mrtrix3-act/tree/1.4) | [doi:10.25663/brainlife.app.319](https://doi.org/10.25663/brainlife.app.319) | current |
| **RACE-Track \| MRTrix3 Anatomical Informed Tractography** (this branch) | 3.0_RC3 | [`1.4`](https://github.com/brainlife/app-mrtrix3-act/tree/1.4) | [doi:10.25663/bl.app.101](https://doi.org/10.25663/bl.app.101) | available |
| **Whole Brain Tractography** (this branch) | 3.0_RC3 | [`1.4`](https://github.com/brainlife/app-mrtrix3-act/tree/1.4) | [doi:10.25663/brainlife.app.318](https://doi.org/10.25663/brainlife.app.318) | deprecated |

- **WMC ACT** exposes only iFOD2 probabilistic tracking, with defaults chosen for white matter tract segmentation (1.5 million streamlines, 25–220 mm, maximum curvature 35°, highest lmax the data support). Use it before the white matter classification Apps.
- **RACE-Track** exposes every option: tensor and CSD models, the iFOD2, iFOD1, SD_STREAM, FACT, Tensor_Det and Tensor_Prob algorithms, several lmax and curvature values, and a streamline count per combination. All candidate streamlines are merged into a single `track.tck`.

RACE-Track replaces the older tracking App [doi:10.25663/bl.app.33](https://doi.org/10.25663/bl.app.33).

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.319](https://doi.org/10.25663/brainlife.app.319) (or the full RACE-Track App at [doi.org/10.25663/bl.app.101](https://doi.org/10.25663/bl.app.101)), choose a preprocessed DWI dataset and a T1-weighted image aligned to it, set the options and press **Execute**. The tractogram (`neuro/track/tck`), the tensor maps (`neuro/tensor`) and the CSD fibre orientation distributions (`neuro/csd`) are archived to your project.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/); MRtrix3, FSL and `jq` come from the `brainlife/mrtrix3` container that `main` pulls.

1. Clone this repository and check out the branch used on brainlife.io (`git checkout 1.4`; the default branch uses `brainlife/mrtrix3:3.0.0`).
2. Create `config.json` with the paths to your inputs and the tracking options:

   ```json
   {
       "diff": "./input/dwi/dwi.nii.gz",
       "bvec": "./input/dwi/dwi.bvecs",
       "bval": "./input/dwi/dwi.bvals",
       "anat": "./input/anat/t1.nii.gz",
       "premask": false,
       "tensor_fit": "",
       "norm": false,
       "imaxs": "",
       "ens_lmax": false,
       "curvs": "35",
       "num_fibers": "1500000",
       "min_length": "25",
       "max_length": "220",
       "do_prb2": true,
       "do_prb1": false,
       "do_detr": false,
       "do_dtdt": false,
       "do_dtpb": false,
       "do_fact": false,
       "fact_dirs": 3,
       "fact_fibs": 0
   }
   ```

   Leave `imaxs` empty to use the highest lmax the data support; set `ens_lmax` to track on every lmax up to that value. `curvs` takes a space-separated list of angles (for example `"5 10 20 40 80"`), and `num_fibers` is the number of streamlines for each lmax, curvature and algorithm combination.

3. Run the App:

   ```bash
   ./main
   ```

### Sample data

Download a T1-weighted image and a preprocessed DWI from brainlife.io with the [brainlife CLI](https://github.com/brainlife/cli):

```bash
npm install -g brainlife
bl login
mkdir input
bl dataset download 5a0e604116e499548135de87 && mv 5a0e604116e499548135de87 input/anat
bl dataset download 5a0dcb1216e499548135dd27 && mv 5a0dcb1216e499548135dd27 input/dwi
```

## Outputs

```text
track.tck          merged tractogram across all requested algorithms, lmax and curvature values
track/track.tck    link to track.tck (neuro/track/tck)
tckinfo.txt        tckinfo summary of the tractogram
tensor/            neuro/tensor: fa, md, ad, rd, cl, cp, cs, tensor (and kurtosis for multi-shell data)
lmax<N>.nii.gz     CSD fibre orientation distribution for every lmax fitted (neuro/csd)
response.txt       CSD response function
fa.nii.gz, md.nii.gz, ad.nii.gz, rd.nii.gz, cl.nii.gz, cp.nii.gz, cs.nii.gz, tensor.nii.gz
5tt.nii.gz, 5ttvis.nii.gz   five-tissue-type image used for ACT and its visualisation
mask.nii.gz        brain mask
product.json       summary shown on brainlife.io
```

## Troubleshooting

- **`iFOD2 Probabilistic tracking timed out with settings ...`**: a single `tckgen` run hit the time limit before reaching the requested count. Lower `num_fibers` or the number of lmax and curvature combinations.
- **`Incorrect count. Tractography failed.`**: the merged tractogram has fewer streamlines than requested. Check the log for the `tckgen` run that fell short and adjust the tracking parameters.
- **Part of the brain is cut off in the tissue segmentation**: if the T1-weighted image is already skull-stripped, set `premask` so that `5ttgen` is run with `-premasked`.
- **The DWI must contain b=0 volumes**; single- and multi-shell data are both supported. For multi-shell data, `tensor_fit` selects the shell used for the tensor fit; if that b-value is not present, all shells are used.
- **Tensor maps in `tensor/`**: on branch `1.4` the code copies `fa.nii.gz` into every file of the `tensor/` folder, so only `tensor/fa.nii.gz` is correct there. The individual maps written at the top level (`md.nii.gz`, `rd.nii.gz`, …) are correct.

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Smith RE, Tournier JD, Calamante F, Connelly A. Anatomically-constrained tractography: improved diffusion MRI streamlines tractography through effective use of anatomical information. *NeuroImage* 62(3):1924–1938 (2012).
- Takemura H, Caiafa CF, Wandell BA, Pestilli F. Ensemble tractography. *PLoS Computational Biology* 12(2):e1004692 (2016).
- Tournier JD, Smith R, Raffelt D, et al. MRtrix3: A fast, flexible and open software framework for medical image processing and visualisation. *NeuroImage* 202:116137 (2019). [doi:10.1016/j.neuroimage.2019.116137](https://doi.org/10.1016/j.neuroimage.2019.116137)
- mrtrix3 - WMC Anatomically Constrained Tractography (ACT). brainlife.io App. [doi:10.25663/brainlife.app.319](https://doi.org/10.25663/brainlife.app.319)
- Whole Brain Tractography. brainlife.io App. [doi:10.25663/brainlife.app.318](https://doi.org/10.25663/brainlife.app.318)
- RACE-Track | MRTrix3 Anatomical Informed Tractography. brainlife.io App. [doi:10.25663/bl.app.101](https://doi.org/10.25663/bl.app.101)
- Smith R.E., Tournier J.D., Calamante F., Connelly A. Anatomically-constrained tractography. NeuroImage 62(3):1924-1938 (2012).
- Takemura H., Caiafa C.F., Wandell B.A., Pestilli F. Ensemble tractography. PLoS Comput Biol 12(2):e1004692 (2016).
- Avesani P. et al. The open diffusion data derivatives. Sci Data 6, 69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)

## Authors

- Brent McPherson

**Contributors:** Soichi Hayashi, Anibal Sólon, Brad Caron, Dan Bullock, Giulia Bertò, Franco Pestilli

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

[MIT](https://github.com/brainlife/app-mrtrix3-act/blob/master/LICENSE). Copyright (c) 2020 Brent McPherson, brainlife.io, Indiana University and The University of Texas at Austin. MRtrix3 and FSL are distributed under their own licenses.
