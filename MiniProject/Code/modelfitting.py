#!/usr/bin/env python3

"""model fitting on TPC for miniproject"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'

import pandas as pd
import numpy as np
from lmfit import minimize, Parameters
import scipy
from numpy import exp

#Import data and select columns to be used
data = pd.read_csv("../Data/BioTraits_modified.csv", usecols =["OriginalTraitValue", "ConTemp","ConTemp_k", 
    "OriginalTraitValue_logged", "B0", "E", "Tl", "Th", "El", "Eh", "id", "ConTemp_rk",
    "Habitat", "ConKingdom", "OriginalTraitName"
    ])

#Constant
#k = scipy.physical_constants["Boltzmann constant in eV/K"][0]
k = 8.617e-5

#Cubic model
def cubic_model(id):
    """Cubic model on TPC curve for miniproject"""
    
    subset = data.loc[data["id"] == id]
    T = np.array(subset.ConTemp) #Temperature
    B = np.array(subset.OriginalTraitValue) #Trait value
    
    Habitat = subset["Habitat"].iloc[0]
    ConKingdom = subset["ConKingdom"].iloc[0]
    OriginalTraitName = subset["OriginalTraitName"].iloc[0]


    params = Parameters()
    
    params.add("B0",value = 0)
    params.add("B1",value = 0)
    params.add("B2",value = 0)
    params.add("B3",value = 0)
    
    #Calculate and minimize the residules
    def cubic_residual(params, T, B):
        """calculate the residuals"""
        
        
        B0 = params["B0"].value
        B1 = params["B1"].value
        B2 = params["B2"].value
        B3 = params["B3"].value

        model = B0+ B1*T + B2*T**2 + B3*T**3

        return model - B
    
#do fitting
    try:

        result = minimize(cubic_residual, params , args = (T,B)) 

        mean = np.mean(B)
        Tss = np.var(B) * (len(B)-1)
        Rss = np.sum(np.square(result.residual))
        Rsqu = 1-(Rss/Tss)
        aic = result.aic
        bic = result.bic
        aicc = aic + 40/(len(T) - 5)
        
    
        all = {"id":[id], 
            "B0":result.params["B0"].value,
            "B1":result.params["B1"].value,
            "B2":result.params["B2"].value,
            "B3":result.params["B3"].value,
            "Rsqu": [Rsqu],
            "aic":[aic],
            "bic":[bic],
            "aicc":[aicc],
            "Habitat":[Habitat],
            "ConKingdom":[ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            }

    
    except(ValueError):
        all = {"id":[id], 
            "B0":[B0],
            "B1":[B1],
            "B2":[B2],
            "B3":[B3],
            "Rsqu": [np.NAN],
            "aic":[np.NAN],
            "bic":[np.NAN],
            "aicc": [np.NAN],
            "Habitat" : [Habitat],
            "ConKingdom" : [ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            } 

    

    return pd.DataFrame(all)

Cubic = pd.DataFrame(data = None)

#fo fit to every response
for id in data["id"].unique():
    final = cubic_model(id)
    Cubic = Cubic.append(final)
    

#save
Cubic.to_csv("../Data/Cubic_model_original.csv",index = False)

#Briere model
def briere_model(id):
    """Cubic model on TPC curve for miniproject"""
    
    subset = data.loc[data["id"] == id]
    T = np.array(subset.ConTemp) 
    B = np.array(subset.OriginalTraitValue) 
    
    Habitat = subset["Habitat"].iloc[0]
    ConKingdom = subset["ConKingdom"].iloc[0]
    OriginalTraitName = subset["OriginalTraitName"].iloc[0]

    T0 = min(T)
    Tm = max(T)

    params = Parameters()
    
    params.add("B0",value = 1)
    params.add("T0",value = T0)
    params.add("Tm",value = Tm)


    
    #Calculate and minimize the residules
    def briere_residual(params, T, B):
        """calculate the residuals"""
        B0 = params["B0"].value


        model = B0 * T *(T - T0) * (Tm - T)**0.5

        return model - B
    
#do fitting
    try:

        result = minimize(briere_residual, params , args = (T,B)) 
        mean = np.mean(B)
        Tss = np.var(B) * (len(B)-1)
        Rss = np.sum(np.square(result.residual))
        Rsqu = 1-(Rss/Tss)
        aic = result.aic
        bic = result.bic
        aicc = aic + 4/(len(T) - 2)
        
    
        all = {"id":[id], 
            "B0":result.params["B0"].value,
            "T0":[T0],
            "Tm":[Tm],
            "Rsqu":[Rsqu],
            "aic":[aic],
            "bic":[bic],
            "aicc":[aicc],
            "Habitat":[Habitat],
            "ConKingdom":[ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            }

    
    except(ValueError): 
        all = {"id":[id], 
            "B0":[B0],
            "T0":[T0],
            "Tm":[Tm],
            "Rsqu": [np.NAN],
            "aic":[np.NAN],
            "bic":[np.NAN],
            "aicc": [np.NAN],
            "Habitat" : [Habitat],
            "ConKingdom" : [ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            } 

    

    return pd.DataFrame(all)

Briere = pd.DataFrame(data = None)

#do fitting for everry response
for id in data["id"].unique():
    final = briere_model(id)
    Briere = Briere.append(final)
    

#save
Briere.to_csv("../Data/Briere_model_original.csv",index = False)

#school model
def school_model(id):
    """Cubic model on TPC curve for miniproject"""
    
    subset = data.loc[data["id"] == id]
    T = np.array(subset.ConTemp_k) 
    B = np.array(subset.OriginalTraitValue) 
    
    Habitat = subset["Habitat"].iloc[0]
    ConKingdom = subset["ConKingdom"].iloc[0]
    OriginalTraitName = subset["OriginalTraitName"].iloc[0]

    B0 = subset["B0"].iloc[0]
    E = subset["E"].iloc[0]
    Tl = subset["Tl"].iloc[0]
    Th = subset["Th"].iloc[0]
    El = subset["El"].iloc[0]
    Eh = subset["Eh"].iloc[0]


    params = Parameters()
    
    params.add("B0", value  = B0, min = 0)
    params.add("E", value = E, min = 0)
    params.add("Tl", value = Tl)
    params.add("Th", value = Th)
    params.add("El", value = El, min = 0)
    params.add("Eh", value = Eh, min = 0)
    
    #Calculate and minimize the residules
    def school_residual(params, T, B):
        """calculate the residuals"""
        
        
        B0 = params["B0"].value
        E = params["E"].value
        Tl = params["Tl"].value
        Th = params["Th"].value
        El = params["El"].value
        Eh = params["Eh"].value

        model = (B0 * exp(-E/k *(1/T - 1/283.15))) / (1 + exp(El/k * (1/Tl - 1/T)) + exp(Eh/k * (1/Th - 1/T)))
        return model - B
    
#do fitting
    try:

        result = minimize(school_residual, params , args = (T,B)) 

        mean = np.mean(B)
        Tss = np.var(B) * (len(B)-1)
        Rss = np.sum(np.square(result.residual))
        Rsqu = 1-(Rss/Tss)
        aic = result.aic
        bic = result.bic
        aicc = aic + 84/(len(T) - 7)
        
    
        all = {"id":[id], 
            "B0":result.params["B0"].value,
            "E":result.params["E"].value,
            "Tl":result.params["Tl"].value,
            "Th":result.params["Th"].value,
            "El":result.params["El"].value,
            "Eh":result.params["Eh"].value,
            "Rsqu": [Rsqu],
            "aic":[aic],
            "bic":[bic],
            "aicc":[aicc],
            "Habitat":[Habitat],
            "ConKingdom":[ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            }

    
    except(ValueError):  #If not converge, return an empty data frame
        all = {"id":[id], 
            "B0":[B0],
            "E":[E],
            "Tl":[Tl],
            "Th":[Th],
            "El":[El],
            "Eh":[Eh],
            "Rsqu": [np.NAN],
            "aic":[np.NAN],
            "bic":[np.NAN],
            "aicc": [np.NAN],
            "Habitat" : [Habitat],
            "ConKingdom" : [ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            } 

    

    return pd.DataFrame(all)

School = pd.DataFrame(data = None)


for id in data["id"].unique():
    final = school_model(id)
    School = School.append(final)
    

#save
School.to_csv("../Data/School_model_original.csv",index = False)


#school model for low tempereture
def school_low_model(id):
    """Cubic model on TPC curve for miniproject"""
    
    subset = data.loc[data["id"] == id]
    T = np.array(subset.ConTemp_k) #Temperature
    B = np.array(subset.OriginalTraitValue) #Trait value
    
    Habitat = subset["Habitat"].iloc[0]
    ConKingdom = subset["ConKingdom"].iloc[0]
    OriginalTraitName = subset["OriginalTraitName"].iloc[0]

    B0 = subset["B0"].iloc[0]
    E = subset["E"].iloc[0]
    Tl = subset["Tl"].iloc[0]
    El = subset["El"].iloc[0]


    params = Parameters()
    
    params.add("B0", value  = B0)
    params.add("E", value = E, min = 0)
    params.add("Tl", value = Tl)
    params.add("El", value = El, min = 0)
    
    #Calculate and minimize the residules
    def school_low_residual(params, T, B):
        """calculate the residuals"""
        
        
        B0 = params["B0"].value
        E = params["E"].value
        Tl = params["Tl"].value
        El = params["El"].value

        model = (B0 * exp(-E/k *(1/T - 1/283.15))) / (1 + exp(El/k * (1/Tl - 1/T)))
        return model - B
    

    try:
        #Try fitting
        result = minimize(school_low_residual, params , args = (T,B)) 
        #Results for model comparison
        mean = np.mean(B)
        Tss = np.var(B) * (len(B)-1)
        Rss = np.sum(np.square(result.residual))
        Rsqu = 1-(Rss/Tss)
        aic = result.aic
        bic = result.bic
        aicc = aic + 84/(len(T) - 7)
        
    
        all = {"id":[id], 
            "B0":result.params["B0"].value,
            "E":result.params["E"].value,
            "Tl":result.params["Tl"].value,
            "El":result.params["El"].value,
            "Rsqu": [Rsqu],
            "aic":[aic],
            "bic":[bic],
            "aicc":[aicc],
            "Habitat":[Habitat],
            "OriginalTraitName":[OriginalTraitName]
            }

    
    except(ValueError):  #If not converge, return an empty data frame
        all = {"id":[id], 
            "B0":[B0],
            "E":[E],
            "Tl":[Tl],
            "El":[El],
            "Rsqu": [np.NAN],
            "aic":[np.NAN],
            "bic":[np.NAN],
            "aicc": [np.NAN],
            "Habitat" : [Habitat],
            "ConKingdom" : [ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            } 

    

    return pd.DataFrame(all)

School_low = pd.DataFrame(data = None)


for id in data["id"].unique():
    final = school_low_model(id)
    School_low = School_low.append(final)
    

#save
School_low.to_csv("../Data/School_low_model_original.csv",index = False)


#school model for high temperature
def school_high_model(id):
    """Cubic model on TPC curve for miniproject"""
    
    subset = data.loc[data["id"] == id]
    T = np.array(subset.ConTemp_k) #Temperature
    B = np.array(subset.OriginalTraitValue) #Trait value
    
    Habitat = subset["Habitat"].iloc[0]
    ConKingdom = subset["ConKingdom"].iloc[0]
    OriginalTraitName = subset["OriginalTraitName"].iloc[0]

    B0 = subset["B0"].iloc[0]
    E = subset["E"].iloc[0]
    Th = subset["Th"].iloc[0]
    Eh = subset["Eh"].iloc[0]


    params = Parameters()
    
    params.add("B0", value  = B0)
    params.add("E", value = E, min = 0)
    params.add("Th", value = Th)
    params.add("Eh", value = Eh, min = 0)
    
    #Calculate and minimize the residules
    def school_high_residual(params, T, B):
        """calculate the residuals"""
        
        
        B0 = params["B0"].value
        E = params["E"].value
        Th = params["Th"].value
        Eh = params["Eh"].value

        model = (B0 * exp(-E/k *(1/T - 1/283.15))) / (1 + exp(Eh/k * (1/Th - 1/T)))
        return model - B
    

    try:
        #Try fitting
        result = minimize(school_high_residual, params , args = (T,B)) 
        #Results for model comparison
        mean = np.mean(B)
        Tss = np.var(B) * (len(B)-1)
        Rss = np.sum(np.square(result.residual))
        Rsqu = 1-(Rss/Tss)
        aic = result.aic
        bic = result.bic
        aicc = aic + 84/(len(T) - 7)
        
    
        all = {"id":[id], 
            "B0":result.params["B0"].value,
            "E":result.params["E"].value,
            "Th":result.params["Th"].value,
            "Eh":result.params["Eh"].value,
            "Rsqu": [Rsqu],
            "aic":[aic],
            "bic":[bic],
            "aicc":[aicc],
            "Habitat":[Habitat],
            "ConKingdom":[ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            }

    
    except(ValueError):  #If not converge, return an empty data frame
        all = {"id":[id], 
            "B0":[B0],
            "E":[E],
            "Th":[Th],
            "Eh":[Eh],
            "Rsqu": [np.NAN],
            "aic":[np.NAN],
            "bic":[np.NAN],
            "aicc": [np.NAN],
            "Habitat" : [Habitat],
            "ConKingdom" : [ConKingdom],
            "OriginalTraitName":[OriginalTraitName]
            } 

    

    return pd.DataFrame(all)

School_high = pd.DataFrame(data = None)


for id in data["id"].unique():
    final = school_high_model(id)
    School_high = School_high.append(final)
    
#Calculate and print the converge ratio of TPCs

School_high.to_csv("../Data/School_high_model_original.csv",index = False)