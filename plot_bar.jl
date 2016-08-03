using PyPlot
using PyCall
@pyimport numpy as np

PyCall.PyDict(matplotlib["rcParams"])["font.sans-serif"] = ["Helvetica"]

# Mutiple Datasets input
MaxYield = readdlm("MaxYield.dat")

# Plot the bar graph with fixed width of the bar
width = 1
a = [1:4:4*length(MaxYield[:,1]);]
threshold = 0.05*ones(a)
PyPlot.matplotlib[:rc]("text",usetex=true)
fig,ax = plt[:subplots](figsize=(15,7))

# Set up the format for presenting each dataset
b_Unbound = ax[:bar](a,MaxYield[:,3],width,align="center",color="white")
b_Block = ax[:bar](a+width,MaxYield[:,4],width,align="center",color="#858585")
b_For = ax[:bar](a+2*width,MaxYield[:,5],width,align="center",color="black")

# Set up the characteristic of the figure
ax[:set_xticks]([])
plt[:margins](0.002)
plt[:ylim]([0,0.4])
plt[:yticks]([0:0.1:0.4],fontsize=20)
plt[:ylabel]("Theoretical Maximum Carbon Yield of POI",fontsize=18)
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
