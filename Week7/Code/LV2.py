import scipy.integrate as integrate
import matplotlib.pylab as p
import scipy as sc
import sys
import matplotlib.backends.backend_pdf as mbbp

def dCR_dt(pops, t = 0):
    
    R = pops[0]
    C = pops[1]
    dRdt = r * R *(1 -R / K)- a * R * C
    dCdt = -z * C + e * a * R * C
    
    return sc.array([dRdt,dCdt])

r = float(sys.argv[1])
a = float(sys.argv[2])
z = float(sys.argv[3])
e = float(sys.argv[4])
K = float(sys.argv[5])

t = sc.linspace(0, 15,  1000)

R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0])

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.text(0.5, 0.5, " r =" + str(r) + "\n a =" + str(a) + "\n z = " + str(z) 
+ "\n e = " + str(e) + "\n K = " + str(K))

f2 = p.figure()

p.plot(pops[:,0], pops[:,1],'r-', ) # Plot
p.grid()
p.legend(loc='best')
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
p.text(0.5, 0.5, " r =" + str(r) + "\n a =" + str(a) + "\n z = " + str(z) 
+ "\n e = " + str(e) + "\n K = " + str(K))

pdf = mbbp.PdfPages('../results/LV2_models.pdf')
pdf.savefig(f1)
pdf.savefig(f2)
pdf.close()