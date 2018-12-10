
import subprocess

p = subprocess.Popen("Rscript fmr.R", stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)

stdout, stderr = p.communicate()

if stderr:
    print("Error!!\n")
    print(stderr.decode())
else:
    print("Successfully called Rscript fmr.R. Yeah!\n")

print(stdout.decode())