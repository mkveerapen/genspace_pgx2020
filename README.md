# GenSpace 2020 Workshop on Personalized Medicine [Pharmacogenomics]: Calculating Polygenic Risk Scores

Materials in this git repository contains materials used during the GenSpace 2020 Workshop on Personalized Medicine. 

_Materials found here are thanks to the inspiration from [Laramie Duncan, PhD](https://neuroscience.stanford.edu/people/laramie-duncan) and Hanyang Shen from Stanford University and [Sam Choi, PhD](https://choishingwan.github.io/) from Icahn School of Medicine, Mount Sinai_

The materials in this repo includes:

1) `GenSpace-Pgx_day2.pdf` : Lecture notes used for the workshop. Sources of materials are cited in the slide deck and pulled together by Kumar Veerapen and Caitlin Cooney. 

2) `Dockerfile` : The hands on section of the workshop was run using the [Hail team container service](workshop.hail.is). The Dockerfile was used to create a docker image that was used for each container notebook deployment. It also installs the R Jupyter notebook functio and `R:fmsb`. The docker image used for the workshop was `gcr.io/hail-vdc/genspace_pgx:0.4`

3) `resources` directory: contains files needed for the running of this workshop materials where
    - `GenSpace-Pgx_day2.ipynb` is the `R` Jupyter notebook that allows you to run the commands used in this workshop.  If you thought that Jupyter notebook was only for `Python` think again! You can use `R` as well. How did I set this up? Look [here](https://www.datacamp.com/community/blog/jupyter-notebook-r)
    - a copy of `plink`v1.90 is included in this repository.
    - binary PLINK files `Pherandom.reduced_1000_Genomes` of `.bim`, `.fam`, `.bed` are listed as `Pherandom.reduced_1000_Genomes`. These files are referred to and elaborated in the R Jupyter notebook in this repository.
    - p-values and effect sizes (beta values) are listed as `MDD_2019_` files. These files are referred to and elaborated in the R Jupyter notebook in this repository.
    - `q.ranges.GWASsig_to_1`: p-value tranche file. This file is referred to and elaborated in the R Jupyter notebook in this repository.
    - `OUTCOME` is a directory that contains the results, and where your results will write into if you are using the main notebook `GenSpace-Pgx_day2.ipynb`.
    _Ancilliary notebooks_
    - `BestFitCheckingPlotting.ipynb` : additional python notebook to check for best fitting p-value tranche.  This notebook is very _raw_ . The annotations are not perfect but you can use this after running the main R notebook (`GenSpace-Pgx_day2.ipynb`) to see which p-value tranche worked best.
    - `QCstepsTaken.ipynb` : What QC steps can you take to clean up your data before running PRS calculations. This notebook is very _raw_ . The annotations are not perfect and was meant as a placeholder for future QC classes.
    - `QC` is a directory that contains QC results from the data if you are using an ancilliary notebook (`QCstepsTaken.ipynb`)
    
4) `GenSpace-Pgx_day2_notebookOutput.pdf` :  This file contains the LaTeX exported pdf output.

Good luck with running your PRS!

If you have any questions, feel free to [email me](mailto:veerapen@broadinstitute.org). 


If you are using any materials from here, PLEASE cite this git repository  https://github.com/mkveerapen/genspace_pgx2020.
