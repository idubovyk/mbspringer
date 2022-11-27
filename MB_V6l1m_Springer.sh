#! /bin/sh -x

math << \_EOF_

path="./"

Get[path<>"MB.m"];

Get[path<>"MBnumericsv2.m"];

(*
Kinematics for massive vertices with two massless external legs.
Examples from Fig.1, I.Dubovyk, A.Freitas, J.Gluza, T.Riemann and J.Usovitsch,
"The two-loop electroweak bosonic corrections to $\sin^2\theta^{b}_{eff}$",
Phys. Lett. B762 (2016), 184
doi:10.1016/j.physletb.2016.09.012, 
https://inspirehep.net/literature/1478370
*)

Clear[s1];
s1 = OpenWrite["res_V6l1m_springer_mink"];

result = {};  

(*
invariants = {p1^2 -> 0, p2^2 -> 0, p1*p2 -> s/2};
invEucl = {MW -> Sqrt[0.78], MZ -> 1, s -> -1, MH -> Sqrt[1.88], 
   MT -> Sqrt[3.6]};
invMink = {MW -> Sqrt[0.78], MZ -> 1, s -> 1, MH -> Sqrt[1.88], 
   MT -> Sqrt[3.6]};
*)

(* some initial kinematic point in Euclidean region *)   
       kinRule2 = {s -> -1/100, MZ-> 1};
(* calculated kinematics *)
       kinRule = {MZ -> 1, s->1+0.0000001*I};
       

MBanalytic={MBint[(Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*(150*EulerGamma^2 + 5*Pi^2 - 120*EulerGamma*Log[-s] + 24*Log[-s]^2))/(24*s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), 
  {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], MBint[(2*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*(5*EulerGamma - 2*Log[-s])*PolyGamma[0, -z2])/
   (s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], 
 MBint[(4*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[0, -z2]^2)/(s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], 
 MBint[-((Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*(5*EulerGamma - 2*Log[-s])*PolyGamma[0, -1 - z2 - z3])/(s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3])), 
  {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], MBint[(-4*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[0, -z2]*PolyGamma[0, -1 - z2 - z3])/
   (s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], 
 MBint[(Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[0, -1 - z2 - z3]^2)/(s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), 
  {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], MBint[(3*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*(5*EulerGamma - 2*Log[-s])*PolyGamma[0, 1 + z3])/
   (2*s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], 
 MBint[(6*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[0, -z2]*PolyGamma[0, 1 + z3])/(s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), 
  {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], MBint[(-3*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[0, -1 - z2 - z3]*PolyGamma[0, 1 + z3])/
   (s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], 
 MBint[(9*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[0, 1 + z3]^2)/(4*s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), 
  {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], MBint[(-3*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[1, -z2])/(s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), 
  {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], MBint[(Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[1, -1 - z2 - z3])/
   (s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], 
 MBint[(5*Gamma[-z2]*Gamma[1 + z2]*Gamma[-1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^3*PolyGamma[1, 1 + z3])/(4*s^2*(-(s/MZ^2))^z2*Gamma[1 - z2 + z3]), 
  {{eps -> 0}, {z2 -> -0.4264399562030828, z3 -> -0.8261188979022515}}], 
 MBint[-((Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*(3*EulerGamma - 2*Log[-s]))/
    (s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2])), {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}], 
 MBint[-((Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*PolyGamma[0, -z1])/(s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2])), 
  {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}], 
 MBint[(-2*Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*PolyGamma[0, -z1 - z2])/
   (s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2]), {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}], 
 MBint[(-4*Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*PolyGamma[0, -z2])/(s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2]), 
  {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}], 
 MBint[(2*Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*PolyGamma[0, -1 - z1 - z3])/
   (s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2]), {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}], 
 MBint[(2*Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*PolyGamma[0, -1 - z2 - z3])/
   (s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2]), {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}], 
 MBint[(2*Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*PolyGamma[0, -1 - z1 - z2 - z3])/
   (s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2]), {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}], 
 MBint[(-2*Gamma[-z1]*Gamma[-1 - z1 - z3]*Gamma[-1 - z2 - z3]*Gamma[-1 - z1 - z2 - z3]*Gamma[-z3]*Gamma[1 + z3]^2*Gamma[1 + z1 + z3]*Gamma[2 + z1 + z2 + z3]*PolyGamma[0, 2 + z1 + z2 + z3])/
   (s^2*(-(s/MZ^2))^z2*Gamma[-z1 - z2]), {{eps -> 0}, {z1 -> -0.2682813941146577, z2 -> -1.0006496807660636, z3 -> -0.17189459577080024}}]};


<< MBsplits.m; 

       Do[restemp=RLstart[todo[[i]], kinRule, kinRule2, AccuracyGoal->3];
         
AppendTo[result, {{kinRule[[1]], kinRule[[2]]}, (Plus @@ (#[[1]] & /@ restemp[[1]])), Sqrt[Plus @@ (#[[2]]^2 & /@ restemp[[1]])]}];

,{i,Length[todo]}];
   

Write[s1,result];
Close[s1];

Exit[];

_EOF_

