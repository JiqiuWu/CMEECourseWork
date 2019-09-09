#!/usr/bin/env python3

"""process json file with cas from CRISPRCasFinder"""

__author__ = 'Jiqiu Wu (j.wu18@imperial.ac.uk)'
__version__ = '0.0.1'
__date__ = '2019.07.24'

#load packages
import json
import os


#load files
# fn = os.listdir("/home/jiqiu/Documents/CMEE/Project/CRISPRCasFinder/Results/Cas")
# #fn = os.listdir("/home/jiqiu/Documents/CMEE/Project/Code/TEST")
# out_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder_infor.csv", "a")

# #save the CRISPRs with cas

# CRISPRs_with_cas = []

# for i in fn:
# 	infor = []
# 	filename = "/home/jiqiu/Documents/CMEE/Project/CRISPRCasFinder/Results/Cas/" + i +"/result.json"
# 	#filename = "/home/jiqiu/Documents/CMEE/Project/Code/TEST/" + i + "/result.json"
# 	f = open(filename,"r")

# 	CRISPRCasFinder_data = json.load(f)
# 	for contig in CRISPRCasFinder_data["Sequences"]:
# 		for cas in contig["Cas"]:
# 			if cas is not None:
# 				for crispr in contig["Crisprs"]:
# 					evidence = crispr.get("Evidence_Level")
# 					if evidence > 2:
# 						contig_id = contig.get("Id")
# 						crispr_id = crispr.get("Name")
# 						num_spacers = crispr.get("Spacers")
						
# 						DR_seq = crispr.get("DR_Consensus")
# 						DR_Length = crispr.get("DR_Length")

# 						print(str(i) + "," + contig_id + "," + crispr_id + "," + str(num_spacers) + "," + str(evidence) + 
#"," + str(DR_Length), file = out_file)


# out_file.close()


#change i(CRISPRCasFinder file ID) to babyID and month

# #load files
# CRISPRCasFinder_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder.csv", "r")
# CRISPRCasFinder_infor = CRISPRCasFinder_file.readlines()

# unique_CRISPRCasFinders = set(CRISPRCasFinder_infor)

# CRISPRCasFinderID_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/CRISPRCasFinderID.csv", "r")
# CRISPRCasFinderID_infor = CRISPRCasFinderID_file.readlines()

# CRISPR_OUT_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/CRISPRCasFinder_sample.csv","a")

# for line in CRISPRCasFinderID_infor:
# 	for element in unique_CRISPRCasFinders:
# 		if line.split(",")[3].rstrip("\n") == element.split(",")[0].rstrip("\n"):
# 			babyID = line.split(",")[0].rstrip("\n")
# 			month = line.split(",")[1].rstrip("\n")
# 			print(str(babyID) + "," + month + "," + element.split(",")[1] + "," + element.split(",")[2] + "," + str(element.split(",")[3]) + 
# 				"," + str(element.split(",")[4]) + "," + str(element.split(",")[5]).rstrip("\n"), file = CRISPR_OUT_file )


# CRISPR_OUT_file.close()



#save the repeats in 0813
#load files
# fn = os.listdir("/home/jiqiu/Documents/CMEE/Project/CRISPRCasFinder/Results/Cas")
# #fn = os.listdir("/home/jiqiu/Documents/CMEE/Project/Code/TEST")
# out_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/repeat.csv", "a")

# #save the CRISPRs with cas



# for i in fn:

# 	filename = "/home/jiqiu/Documents/CMEE/Project/CRISPRCasFinder/Results/Cas/" + i +"/result.json"
# 	#filename = "/home/jiqiu/Documents/CMEE/Project/Code/TEST/" + i + "/result.json"
# 	f = open(filename,"r")

# 	CRISPRCasFinder_data = json.load(f)
# 	for contig in CRISPRCasFinder_data["Sequences"]:
# 		for cas in contig["Cas"]:
# 			if cas is not None:
# 				for crispr in contig["Crisprs"]:
# 					evidence = crispr.get("Evidence_Level")
# 					if evidence > 2:
# 						contig_id = contig.get("Id")
# 						crispr_id = crispr.get("Name")
# 						#num_spacers = crispr.get("Spacers")
						
# 						DR_seq = crispr.get("DR_Consensus")
# 						DR_Length = crispr.get("DR_Length")

# 						print(str(i) + "," + contig_id + "," + crispr_id + "," + DR_seq + "," + str(DR_Length), file = out_file)


# out_file.close()

# #change i(CRISPRCasFinder file ID) to babyID and month

# #load files
# CRISPRCasFinder_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/repeat.csv", "r")
# CRISPRCasFinder_infor = CRISPRCasFinder_file.readlines()

# unique_CRISPRCasFinders = set(CRISPRCasFinder_infor)

# CRISPRCasFinderID_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/CRISPRCasFinderID.csv", "r")
# CRISPRCasFinderID_infor = CRISPRCasFinderID_file.readlines()

# CRISPR_OUT_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/repeat_sample.csv","a")

# for line in CRISPRCasFinderID_infor:
# 	for element in unique_CRISPRCasFinders:
# 		if line.split(",")[3].rstrip("\n") == element.split(",")[0].rstrip("\n"):
# 			babyID = line.split(",")[0].rstrip("\n")
# 			month = line.split(",")[1].rstrip("\n")
# 			print(str(babyID) + "," + month + "," + element.split(",")[1] + "," + element.split(",")[2] + "," + element.split(",")[3] + 
# 				"," + str(element.split(",")[4]).rstrip("\n"), file = CRISPR_OUT_file )


# CRISPR_OUT_file.close()


#save the spacers in 0820

#load files
# fn = os.listdir("/home/jiqiu/Documents/CMEE/Project/CRISPRCasFinder/Results/Cas")
# #fn = os.listdir("/home/jiqiu/Documents/CMEE/Project/Code/TEST")
# out_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/Spacers/spacers.csv", "a")

# for i in fn:

# 	filename = "/home/jiqiu/Documents/CMEE/Project/CRISPRCasFinder/Results/Cas/" + i +"/result.json"
# 	#filename = "/home/jiqiu/Documents/CMEE/Project/Code/TEST/" + i + "/result.json"
# 	f = open(filename,"r")

# 	CRISPRCasFinder_data = json.load(f)
# 	for contig in CRISPRCasFinder_data["Sequences"]:
# 		for cas in contig["Cas"]:
# 			if cas is not None:
# 				for crispr in contig["Crisprs"]:
# 					evidence = crispr.get("Evidence_Level")
# 					if evidence > 2:
# 						contig_id = contig.get("Id")
# 						crispr_id = crispr.get("Name")
# 						num_spacers = crispr.get("Spacers")
						
# 						spacer_id = range(1, num_spacers + 1)

# 						spacers_seq = []
# 						for motif in crispr["Regions"]:

# 							if motif.get("Type") == "Spacer":
# 								spacer = motif.get("Sequence")
# 								spacers_seq.append(spacer)

# 						for m,n in zip(spacer_id,spacers_seq):
# 							print(str(i) + "," + contig_id + "," + crispr_id + "," + crispr_id + "_" + str(m) + ","+ n.rstrip("\n"), file = out_file)


# out_file.close()

#change i(CRISPRCasFinder file ID) to babyID and month

#load files
CRISPRCasFinder_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/Spacers/spacers.csv", "r")
CRISPRCasFinder_infor = CRISPRCasFinder_file.readlines()

unique_CRISPRCasFinders = set(CRISPRCasFinder_infor)
print(len(unique_CRISPRCasFinders))

CRISPRCasFinderID_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/CRISPRCasFinder/CRISPRCasFinderID.csv", "r")
CRISPRCasFinderID_infor = CRISPRCasFinderID_file.readlines()

CRISPR_OUT_file = open("/home/jiqiu/Documents/CMEE/Project/Redo_0724/Spacers/spacer_sample.csv","a")

for line in CRISPRCasFinderID_infor:
	for element in unique_CRISPRCasFinders:
		if line.split(",")[3].rstrip("\n") == element.split(",")[0].rstrip("\n"):
			babyID = line.split(",")[0].rstrip("\n")
			month = line.split(",")[1].rstrip("\n")
			print(str(babyID) + "," + month + "," + element.split(",")[1] + "," + element.split(",")[2] + "," + element.split(",")[3] + 
				"," + str(element.split(",")[4]).rstrip("\n"), file = CRISPR_OUT_file )


CRISPR_OUT_file.close()