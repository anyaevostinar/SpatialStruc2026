'''
Grabs data from munged_basic_tasks.dat
for taskCompleetionAnalysis R file
'''


import os.path
import gzip

file = 'munged_basic_tasks.dat'
completion_amount = 1000


header = "treatment task count partner\n"
task_names = {1:"NAND", 2:"NOT", 3:"OR_NOT", 4:"AND", 5:"OR", 6:"AND_NOT", 
    7:"NOR", 8:"XOR", 9:"EQU"}

outputFileName = "rep_task_count.dat"

host_completion_dict_by_rep: dict[str,int] = {}
host_completion_dict: dict[str,int] = {}

sym_completion_dict_by_rep: dict[str,int] = {}
sym_completion_dict: dict[str,int] = {}
curFile = open(file, 'r')
for line in curFile:
    if (line[0] != "u"):
        splitline = line.strip().split(' ')
        if(len(splitline) <= 1):
            continue
  
        if(splitline[6] == "Host"):
            key = splitline[1] + " " + splitline[2] + " " + splitline[4]
            if(key in host_completion_dict_by_rep):
                host_completion_dict_by_rep[key] += int(float(splitline[5]))
            else:
                host_completion_dict_by_rep[key] = int(float(splitline[5]))
            
        if(splitline[6] == "Sym"):
            key = splitline[1] + " " + splitline[2] + " " + splitline[4]
            if(key in sym_completion_dict_by_rep):
                sym_completion_dict_by_rep[key] += int(float(splitline[5]))
            else:
                sym_completion_dict_by_rep[key] = int(float(splitline[5]))
for r in host_completion_dict_by_rep.keys():
    split_key = r.split(' ')
    combined_key = split_key[0] + " " + split_key[2]
    if(combined_key not in host_completion_dict):
        host_completion_dict[combined_key] = 0
    if(host_completion_dict_by_rep[r] > completion_amount):
        host_completion_dict[combined_key] += 1

for r in sym_completion_dict_by_rep.keys():
    split_key = r.split(' ')
    combined_key = split_key[0] + " " + split_key[2]
    if(combined_key not in sym_completion_dict):
        sym_completion_dict[combined_key] = 0
    if(sym_completion_dict_by_rep[r] > completion_amount):
        sym_completion_dict[combined_key] += 1
    

curFile.close()
outFile = open(outputFileName, 'w')
outFile.write(header)
for r in host_completion_dict.keys():
    split_key = r.split(' ')
    outstring = "{} {} {} {}\n".format(split_key[0],split_key[1],host_completion_dict[r],"Host")
    outFile.write(outstring)

for r in sym_completion_dict.keys():
    split_key = r.split(' ')
    outstring = "{} {} {} {}\n".format(split_key[0],split_key[1],sym_completion_dict[r],"Sym")
    outFile.write(outstring)

outFile.close()
