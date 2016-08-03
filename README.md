# PMP_CellFree_Model_Repository
Model code for Che-hsiao Shih project

Flux balance analysis is a widely-adapted, constraint-based approach in reconstructing the metabolic network in microorganisms. In this work, we were interested in the protein synthesis network in the All E. coli TX-TL Cell-Free Toolbox 2.0, which in practical provides an efficient medium for expressing target sequence of interest and in turn giving the polypeptide chain. Eight different network were generated on Kwatee system and synthetic model code generator server with the cell-free model plugin. The codes were aiming to, respectively, maximize the export flux of eight different protein of interest, listed as following:
* BMP10: Bone Morphogenetic Protein 10
* CAT: Chloramphenicol Acetyltransferase
* dCas9: Caspase 9
* deGFP: Green Fluorescent Protein
* F2: Prothrombin/ Coagulation Factor II
* F10: Coagulation Factor X
* FGF21: Fibroblast Growth Factor 21
* scFvR4: Single-Chain Variable Fragment R4

Each protein of interest has two repositories, and the main difference between them is whether Cell-Free TX-TL model is integrated into the code or not. Certain metabolic pathways can be blocked or regulated either by adding blocked reactions or by giving additional constraints on the network. In Cell-Free TX-TL system, `PlasmidConcentration.jl` was run first to decide optimum plasmid concentration. The file `MaxProduct.jl` gives the optimum flux distribution in the network.
The code was run on Julia with GLPK linear programming solver, while plotting was conducted by using PyPlot.
