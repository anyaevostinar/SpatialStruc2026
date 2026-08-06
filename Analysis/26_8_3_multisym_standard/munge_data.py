import os.path
import gzip

folder = '../../Data/26_8_3_multisym_standard/'

treatment_folders = ["health-mutualists-ms2",
"health-mutualists-ms5",
"health-parasites-ms2",
"health-parasites-ms5",
"nutrient-parasites-ms2",
"nutrient-parasites-ms5"]

reps = range(100,130)
header = "uid treatment rep update task task_count partner\n"
task_names = {1:"NAND", 2:"NOT", 3:"OR_NOT", 4:"AND", 5:"OR", 6:"AND_NOT", 
    7:"NOR", 8:"XOR", 9:"EQU"}

outputFileName = 'munged_tasks.dat'
outFile = open(outputFileName, 'w')
outFile.write(header)

for t in treatment_folders:
    for r in reps:
        fname = folder + "/"+t+"/" + str(r) + "/Data" + "/Tasks_data.csv"
        uid = t + "_" + str(r)
        curFile = open(fname, 'r')
        for line in curFile:
            if (line[0] != "u"):
                splitline = line.strip().split(',')
                for task in range(1,10): # nine logic tasks
                    outstring1 = "{} {} {} {} {} {} {}\n".format(uid, t, r, splitline[0], task_names[task], splitline[task], "Host")
                    outFile.write(outstring1)
                for task in range(10,19): # nine logic tasks
                    outstring1 = "{} {} {} {} {} {} {}\n".format(uid, t, r, splitline[0], task_names[task-9], splitline[task], "Sym")
                    outFile.write(outstring1)
        curFile.close()
outFile.close()
