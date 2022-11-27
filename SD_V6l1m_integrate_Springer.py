from __future__ import print_function
from pySecDec.integral_interface import IntegralLibrary
import sympy as sp
from random import *
import os
import yaml

# load c++ library
triangle2L_wu = IntegralLibrary('triangle2L_wu/triangle2L_wu_pylink.so')

# choose integrator
triangle2L_wu.use_Qmc(verbosity=2,minn=50000,maxeval=1,transform='korobov3')

#r0=uniform(0.1,1)

#r0=1352./519
r1=1
r3=0.6

# integrate
str_integral_without_prefactor, str_prefactor, str_integral_with_prefactor = triangle2L_wu([1,r1,1,r3,1,1])

# convert complex numbers from c++ to sympy notation
str_integral_with_prefactor = str_integral_with_prefactor.replace(',','+I*')
str_prefactor = str_prefactor.replace(',','+I*')
str_integral_without_prefactor = str_integral_without_prefactor.replace(',','+I*')

# convert result to sympy expressions
integral_with_prefactor = sp.sympify(str_integral_with_prefactor.replace('+/-','*value+error*'))
integral_with_prefactor_err = sp.sympify(str_integral_with_prefactor.replace('+/-','*value+error*'))
prefactor = sp.sympify(str_prefactor)
integral_without_prefactor = sp.sympify(str_integral_without_prefactor.replace('+/-','*value+error*'))
integral_without_prefactor_err = sp.sympify(str_integral_without_prefactor.replace('+/-','*value+error*'))

# numerical result
print('r0=%s, r1=%s, r3=%s' %(1,r1,r3))
print('Numerical Result')
print('eps^-2:', integral_with_prefactor.coeff('eps',-2).coeff('value'), '+/- (', integral_with_prefactor_err.coeff('eps',-2).coeff('error'), ')')
print('eps^-1:', integral_with_prefactor.coeff('eps',-1).coeff('value'), '+/- (', integral_with_prefactor_err.coeff('eps',-1).coeff('error'), ')')
print('eps^0:', integral_with_prefactor.coeff('eps',0).coeff('value'), '+/- (', integral_with_prefactor_err.coeff('eps',0).coeff('error'), ')')

# result from arXiv:1610.07059 (equation 3.2)
# Note: The result given in the reference above has a sign error in the finite part.
#       The result given below has been confirmed by the authors of arXiv:1610.07059
#       in a private communication.
#	print('Reference Result')
#	print('eps^-2: 1.23370055013617    - 6.20475892887384  * 10^-13 * I')
#	print('eps^-1: 2.8902545096591976  + 3.875784585038738          * I')
#	print('eps^0:  0.7785996083247692  + 4.123512600516016          * I')

#int_name= 'INT2'
#result = {}
#result['r1'] = r1
#result['r3'] = r3
#result['name'] = int_name
#result['result'] = {}
#for i in range(-4,5):
#    result['result'][str(i)] = {
#                                    'res' : str(integral_with_prefactor.coeff('eps', i).coeff('value')),
#                                    'err' : str(integral_with_prefactor_err.coeff('eps', i).coeff('error'))
#                                }
#    with open(int_name+'.yaml','w') as f:
#        yaml.dump(result,stream=f)