import matplotlib.pylab as p
import scipy as sc
import sys
import matplotlib.backends.backend_pdf as mbbp

def dCR_dt(RC0, t=0):
    
    RC = sc.zeros((t, 2), dtype='float')  # pre-allocate
    RC[0, 0] = RC0[0]
    RC[0, 1] = RC0[1]
    for i in range(t-1):
        RC[i+1, 0] = RC[i, 0] * (1 + r * (1 - RC[i, 0] / K) - a * RC[i, 1])
        RC[i+1, 1] = RC[i, 1] * (1 - z + e * a * RC[i, 0])

    return RC

r = float(sys.argv[1])
a = float(sys.argv[2])
z = float(sys.argv[3])
e = float(sys.argv[4])
K = float(sys.argv[5])

t = sc.linspace(0, 15,  1000)

R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0])
RC = dCR_dt(RC0, t)

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

f1 = p.figure()

p.plot(range(t), RC[:, 0], 'g-', label='Resource density') # Plot
p.plot(range(t), RC[:, 1], 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.text(0.5, 0.5, " r =" + str(r) + "\n a =" + str(a) + "\n z = " + str(z) 
+ "\n e = " + str(e) + "\n K = " + str(K))

f2 = p.figure()

p.plot(RC[:, 0], RC[:, 1],'r-',label='Consumer density') # Plot
p.grid()
p.legend(loc='best')
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
p.text(0.5, 0.5, " r =" + str(r) + "\n a =" + str(a) + "\n z = " + str(z) 
+ "\n e = " + str(e) + "\n K = " + str(K))

pdf = mbbp.PdfPages('../results/LV3_models.pdf')
pdf.savefig(f1)
pdf.savefig(f2)
pdf.close()