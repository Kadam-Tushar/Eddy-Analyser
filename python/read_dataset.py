import netCDF4 as nc
import numpy as np 
from mpl_toolkits import mplot3d

import matplotlib.pyplot as plt
fn = ' /home/tushar/iisc/gav/project/dataset/0001/COMBINED_2011013100.nc'
ds = nc.Dataset(fn)
import matplotlib
fig = plt.figure()
ax = plt.axes(projection='3d')
#print(ds)
# for dim in ds.dimensions.values():
#     print(dim)

# for var in ds.variables.values():
#     print(var)

#print(ds['U'])

# salt =ds['TEMP'][20,20,300,300]
# print(salt)

# long = ds['XC'][20]
# print(long)

# float64 TEMP(T_AX, Z_MIT40, YC, XC)
#                (60,50,500,500)

# sn,ss,w

# print(ds['YC'][220])
# print(ds['YG'][220])
# print(ds['T_AX'][5])
#float64 U(T_AX, Z_MIT40, YC, XG)
#float64 V(T_AX, Z_MIT40, YG, XC)
#yc : latitude degree north
#xg : long degree east
val = ds['U'][0]

# t= 0 
# for i in range(50):
#     print(i)
#     for k in range(499):
#         print(k)
#         for j in range(499):
#             u1 = ds['U'][t,i,j,k]
#             u2 = ds['U'][t,i+1,j,k]
#             ux = u2 - u1 

#             u1 = ds['U'][t,i,j,k]
#             u2 = ds['U'][t,i,j+1,k]
#             uy = u2 - u1 

#             v1 = ds['V'][t,i,j,k]
#             v2 = ds['V'][t,i+1,j,k]
#             vx = v2 - v1 

#             v1 = ds['V'][t,i,j,k]
#             v2 = ds['V'][t,i,j+1,k]
#             vy = v2 - v1 
            

#             sn = ux - vy 
#             ss = vx + uy
#             w = vx- uy

#             ow = sn*sn + ss*ss - w*w 
#             if abs(ow) >= 0.1 :
#                 print(ow)





            