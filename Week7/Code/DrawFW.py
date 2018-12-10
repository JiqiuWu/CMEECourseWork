import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

def GenRdmAdjList(N = 2, C = 0.5):
    """ 
   define a 
    """
    Ids = range(N)
    ALst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C:
            Lnk = sc.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops
                ALst.append(Lnk)
    return ALst #using a uniform random distribution between [0,1] 
    #to generate a connectance probability between each species pair.

MaxN = 30
C = 0.75 
#ssign number of species (MaxN) and connectance (C)
AdjL = sc.array(GenRdmAdjList(MaxN, C))
#two columns of numbers correspond to the consumer and resource ids, respectively.

Sps = sc.unique(AdjL) # get species ids

SizRan = ([-10,10]) #use log10 scale
Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)

p.hist(Sizs) #log10 scale
p.hist(10 ** Sizs) #raw scale

p.close('all') # close all open plot objects

pos = nx.circular_layout(list(Sps))

G = nx.Graph()

G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL)) # this function needs a tuple input

NodSizs= 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs)) 

f = p.figure()
nx.draw_networkx(G, pos, node_size = NodSizs)
f.savefig('../Results/DrawFW.pdf')
p.close('all')