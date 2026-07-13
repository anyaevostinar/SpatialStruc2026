import os.path
import gzip

folder = '../../Data/26_7_10_health_treatment/'

treatment_folders = ["parasites-mixed", "parasites-grid", "nosyms-grid-flat", "mutualists-mixed", "mutualists-grid", "nosyms-grid-diff"]

reps = range(100,130)
header = "uid treatment rep update horiz_attempts horiz_successes vert_attempts vert_successes\n"

outputFileName = "munged_TransmissionRates.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

for t in treatment_folders:
    for r in reps:
        fname = folder + "/"+t+"/" + str(r) + "/Results" + "/TransmissionRates_data.csv"
        uid = t + "_" + str(r)
        curFile = open(fname, 'r')
        for line in curFile:
            if (line[0] != 'u'):
                splitline = line.strip().split(',')
                horiz_attempts = sum(int(splitline[i]) for i in range(1, 11))
                horiz_successes = sum(int(splitline[i]) for i in range(11, 21))
                vert_attempts = sum(int(splitline[i]) for i in range(21, 31))
                vert_successes = sum(int(splitline[i]) for i in range(31, 41))
                outRow = f'{uid} {t} {r} {splitline[0]} {horiz_attempts} {horiz_successes} {vert_attempts} {vert_successes}'
                outFile.write(outRow)
        curFile.close()
outFile.close()
