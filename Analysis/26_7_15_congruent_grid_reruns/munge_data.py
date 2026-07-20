import os.path
import gzip

folder = '../../Data/26_7_15_congruent_grid_reruns/'

stress_treatment_folders = ["stress-parasites-mixed", "stress-parasites-grid", "stress-mutualists-mixed", "stress-mutualists-grid"]
health_treatment_folders = ["health-parasites-mixed", "health-parasites-grid", "health-mutualists-mixed", "health-mutualists-grid"]
nutrient_treatment_folders = ["nutrient-parasites-mixed", "nutrient-parasites-grid", "nutrient-mutualists-mixed", "nutrient-mutualists-grid"]
nutrient_nosyms_treatment_folders = ["nosyms-nutrient-grid-flat","nosyms-nutrient-mixed-flat"]
stress_nosyms_treatment_folders = ["nosyms-stress-grid-diff","nosyms-stress-grid-flat","nosyms-stress-mixed-diff","nosyms-stress-mixed-flat"]
nosyms_treatment_folders = ["nosyms-grid-diff","nosyms-grid-flat","nosyms-mixed-diff","nosyms-mixed-flat"]

groups = [('stress_tasks.dat', stress_treatment_folders),
  ('health_tasks.dat', health_treatment_folders),
  ('nutrient_tasks.dat', nutrient_treatment_folders),
  ('stress_nosyms_tasks.dat', stress_nosyms_treatment_folders),
  ('nutrient_nosyms_tasks.dat', nutrient_nosyms_treatment_folders),
  ('nosyms_tasks.dat', nosyms_treatment_folders)]

reps = range(100,130)
header = "uid treatment rep update task task_count partner\n"
task_names = {1:"NAND", 2:"NOT", 3:"OR_NOT", 4:"AND", 5:"OR", 6:"AND_NOT", 
    7:"NOR", 8:"XOR", 9:"EQU"}

for group in groups:

  outputFileName = group[0]
  outFile = open(outputFileName, 'w')
  outFile.write(header)

  treatment_folders = group[1]
  for t in treatment_folders:
      for r in reps:
          fname = folder + "/"+t+"/" + str(r) + "/Results" + "/Tasks_data.csv"
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
