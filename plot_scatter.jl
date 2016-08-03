using PyPlot
using PyCall
@pyimport numpy as np

PyCall.PyDict(matplotlib["rcParams"])["font.sans-serif"] = ["Helvetica"]

# Data input
MaxYield = readdlm("MaxYield.dat")

# Plot the bar graph with fixed width of the bar
width = 1
a = [1:2:2*length(MaxYield[:,1]);]
PyPlot.matplotlib[:rc]("text",usetex=true)
fig,ax = plt[:subplots](figsize=(15,7))
b_MaxYield = ax[:scatter](MaxYield[:,2],MaxYield[:,5],s=40,c="black")

# Set up the characteristic of the figure
#ax[:set_xticks]([])
plt[:margins](0.002)
plt[:xlim]([500,3500])
plt[:xticks]([500:500:3500],fontsize=18)
plt[:xlabel]("Number of Carbon in POI",fontsize=18)
plt[:ylim]([0.00,0.12])
plt[:yticks]([0.00:0.02:0.12],fontsize=18)
plt[:ylabel]("Theoretical Maximum Carbon Yield of POI",fontsize=18)
plt[:tick_params](axis="x",which="both",bottom="on",top="on")
