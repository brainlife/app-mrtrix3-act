# app-mrtrix3-act

This app uses a similar algorithm to brainlife.io's ensemble tracking App (https://doi.org/10.25663/bl.app.33) except it uses mrtrix3/act (Anatomically Constrained Tractography (ACT) algorithm. 

This App generates a large set of candidate streamlines using various DWI models such as tensor and csd-based models and run mrtrix3 tckgen with various algorithms (iFOD1, iFOD2, FACT, SD_STREAM, Tensor_Det, Tensor_Prod. The csd-based models can be computed at various lmax. All candidate streamlines are combined into a single track.tck file.

## References

Takemura, H., Caiafa, C. F., Wandell, B. A., & Pestilli, F. (2016). Ensemble tractography. PLoS computational biology, 12(2), e1004692.
