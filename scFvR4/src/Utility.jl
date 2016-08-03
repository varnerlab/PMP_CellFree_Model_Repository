include("Types.jl")

# ================================================================================== #
# Utility.jl
# Library for setup functions for NFBA calculations for code generated by Kwatee
#
# Author: Varnerlab
# Chemical Engineering, Purdue University
# ================================================================================== #

function calculateDilutionSelectionArray(species_model_dictionary::Dict{AbstractString,SpeciesModel})

  # Method variables -
  number_of_species = length(species_model_dictionary);
  dilution_selection_array = ones(Float64,number_of_species);

  # Iterate through the species models, and formulate the dsa -
  for (key,species_model::SpeciesModel) in species_model_dictionary

      # index -
      species_index = species_model.species_index;

      # Query the dilution status for this species -
      if (species_model.is_species_diluted == false)
        dilution_selection_array[species_index] = 0.0;
      end
  end

  return dilution_selection_array;
end

function calculateGrowthCoefficientArray(species_model_dictionary::Dict{AbstractString,SpeciesModel})

  # Method variables -
  number_of_species = length(species_model_dictionary);
  growth_coeffient_array = zeros(Float64, number_of_species);

  # Iterate through the species models, and formulate the dsa -
  for (key,species_model::SpeciesModel) in species_model_dictionary

      # index -
      species_index = species_model.species_index;
      if (species_model.is_biomass_precursor == true)

        precursor_coeff = species_model.biomass_precursor_coefficient;
        growth_coeffient_array[species_index] = precursor_coeff;

      end
  end

  return growth_coeffient_array;
end

function calculateInitialConditionArray(species_model_dictionary::Dict{AbstractString,SpeciesModel})

  # Method variables -
  number_of_species = length(species_model_dictionary);
  initial_condition_array = zeros(Float64,number_of_species);

  # Iterate through the species models, and formulate the dsa -
  for (key,species_model::SpeciesModel) in species_model_dictionary

      # index -
      species_index = species_model.species_index;
      initial_condition = species_model.species_initial_condition;

      # add to array -
      initial_condition_array[species_index] = initial_condition;
  end

  return initial_condition_array
end

function calculateTimeDelayParameterArray(species_model_dictionary::Dict{AbstractString,SpeciesModel})

  # Method variables -
  number_of_species = length(species_model_dictionary);
  tau_array = ones(Float64,number_of_species);

  # Iterate through the species models, and formulate the dsa -
  for (key,species_model::SpeciesModel) in species_model_dictionary

      # index -
      species_index = species_model.species_index;
      tau_constant = species_model.species_time_constant;
      tau_array[species_index] = tau_constant;
  end

  return tau_array;

end

function calculateStateMappingIndexArray(unsorted_index_array::Array{Int,1})

  # How many elements do we have?
  number_of_elements = length(unsorted_index_array);

  # Generate unsorted array -
  tmp_array = Array(Int,number_of_elements,2)
  index_counter = 1;
  for index in collect(1:number_of_elements)

    tmp_array[index_counter,1] = unsorted_index_array[index]
    tmp_array[index_counter,2] = index_counter;

    index_counter+=1;
  end

  # sort in place -
  tmp_array = sortrows(tmp_array,by=x->(x[1]));

  return tmp_array[:,2];
end

function splitStoichiometricMatrixIntoInternalExternalBlocks(data_dictionary::Dict)

  # Method variables -
  species_model_dictionary = data_dictionary["SPECIES_MODEL_DICTIONARY"];
  stoichiometric_matrix = data_dictionary["STOICHIOMETRIC_MATRIX"];
  number_of_fluxes = data_dictionary["NUMBER_OF_FLUXES"];
  extracellular_index_array = Int[]
  intracellular_index_array = Int[]

  # How many extracellular/intracellular species do we have?
  for (key,species_model::SpeciesModel) in species_model_dictionary

    if (species_model.is_species_extracellular == true)
      push!(extracellular_index_array,species_model.species_index);
    else
      push!(intracellular_index_array,species_model.species_index);
    end
  end

  # sort the index arrays -
  sort!(extracellular_index_array);
  sort!(intracellular_index_array);

  # allocate the arrays -
  intracellular_block = stoichiometric_matrix[intracellular_index_array,:];
  extracellular_block = stoichiometric_matrix[extracellular_index_array,:];

  # return -
  return (intracellular_index_array, extracellular_index_array, intracellular_block, extracellular_block)
end