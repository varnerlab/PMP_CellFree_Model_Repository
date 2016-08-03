# Script to max product -
include("DataFile.jl")
include("Solve.jl")
include("Types.jl")

# Setup the objective -
data_dictionary = DataFile(0,0,0);
number_of_fluxes = data_dictionary["NUMBER_OF_FLUXES"];

# Set the max -
data_dictionary["MIN_FLAG"] = false;

# Get the flux model dictionary -
flux_model_dictionary = data_dictionary["FLUX_MODEL_DICTIONARY"]

#Optimize Protein of Interest Production
flux_model = flux_model_dictionary["PROTEIN_export_FGF21"];
flux_model.flux_obj_coeff = 1.0;

# set the bound -
data_dictionary["M_o2_c_exchange_reverse"] = 100
data_dictionary["translation_FGF21_switch_bound"] = false
plasmid_concentration = 0.929;
data_dictionary["FGF21_gene_copies"] = (10e-6/1e9)*(6.02e23)*plasmid_concentration;

# Call solve -
(OV,FA,DA,UA,EF) = Solve(data_dictionary);

# Write the flux file -
writedlm("../output.txt",(OV,FA))
writedlm("../output.dat",(OV,FA[251],FA[191],FA[193],FA[195],FA[197],FA[199],FA[201],FA[203],FA[205],FA[207],FA[209],FA[211],FA[213],FA[215],FA[217],FA[219],FA[221],FA[223],FA[225],FA[227],FA[229],FA[252],FA[254],FA[256],FA[260],FA[262],FA[264],FA[258]))
