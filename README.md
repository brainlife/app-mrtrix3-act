[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.1-blue.svg)](https://doi.org/10.25663/bl.app.101)

# app-mrtrix3-act

This app uses MRTrix3 to create **R**eprocible **A**natomically **C**onstrained **E**nsemble **Track**ing (RACE-Track).

The app generates a set of streamlines for every requested tractography model (Tensor or CSD) and algorithm (iFOD1, iFOD2, FACT, SD_STREAM, Tensor_Det, Tensor_Prod). A final output of the merged streamlines is returned to the user for further analysis.

** IMPORTANT **
This code is used in multiple apps, some of which restrict the options available to the user. This is to more easily reproduce desired outputs for specific use cases (networks, specific features in the anatomy, etc.). The same code is run, but some parameters may have been fixed by the developer based on their work for a specific use. 

The CSD-based models can be computed at different $l_{max}$ values. All candidate streamlines are combined into a single track.tck file.

Additionally, the Tensor (and Kurtosis if data is multishell) and the CSD models are stored as well.

This is a replacement for older processes (https://doi.org/10.25663/bl.app.33).

### Authors
- [Brent McPherson](bcmcpher@iu.edu)

### Contributors
- [Soichi Hayashi](hayashis@iu.edu)

### Project Director
- Franco Pestilli (frakkopesto@gmail.com)

### Funding Acknowledgement
brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations
Please cite the following articles when publishing papers that used data, code or other resources created by the brainlife.io community.

1. Smith, R. E., Tournier, J. D., Calamante, F., & Connelly, A. (2012). Anatomically-constrained tractography: improved diffusion MRI streamlines tractography through effective use of anatomical information. Neuroimage, 62(3), 1924-1938.
2. Takemura, H., Caiafa, C. F., Wandell, B. A., & Pestilli, F. (2016). Ensemble tractography. PLoS computational biology, 12(2), e1004692.
3. Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). [https://doi.org/10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Running the App 

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/bl.app.101](https://doi.org/10.25663/bl.app.101) via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
    "anat": "./input/anat/t1.nii.gz",
	"dwi": "./input/dwi.nii.gz",
	"bvecs": "./input/dwi.bvecs",
	"bvals": "./input/dwi.bvals",
}
```

3. Launch the App by executing `main`

```bash
./main
```

### Sample Datasets

If you don't have your own input file, you can download sample datasets from Brainlife.io, or you can use [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 5a0e604116e499548135de87 && mv 5a0e604116e499548135de87 input/track
bl dataset download 5a0dcb1216e499548135dd27 && mv 5a0dcb1216e499548135dd27 input/dtiinit
```

## Output

track.tck
- the merged anatomically constrained tractography across all requested combinations of parameters

tensor
- tensor.nii.gz
- kurtosis.nii.gz (if multishell)
- fa.nii.gz
- md.nii.gz
- rd.nii.gz
- ad.nii.gz
- cl.nii.gz
- cp.nii.gz
- cs.nii.gz

csd
- lmax??.nii.gz for every requested lmax


#### Product.json

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing. 

### Dependencies

This App only requires [singularity](https://www.sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies.  

  - MRTrix3: https://www.mrtrix.org/
  - FSL: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki
  - ANTs: http://stnava.github.io/ANTs/

