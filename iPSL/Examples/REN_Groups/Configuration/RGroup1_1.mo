within iPSL.Examples.REN_Groups.Configuration;
model RGroup1_1 "Machine configuration of synchronous machine with regulators: GENSAL, ESST1A, HYGOV, IEEEST; 
  from REN model: Buses XXX
  Configuration from Bus 78292
  Exciter reg_esst1a_8d802d16_f9a2_11e4_b5b1_78acc0ae2875
  Stabilizer reg_ieeest_8d802d16_f9a2_11e4_b5b1_78acc0ae2875
  Governor reg_hygov_8d802d16_f9a2_11e4_b5b1_78acc0ae2875"
  //Notes
  //1. In GENSAL: Sbase could be necessary
  //2. In ESST1A: cont.y connected always to VUEL1 and VOTHSG
  //
  Electrical.Machines.PSSE.GENSAL.GENSAL gENSAL(
    Tpd0=8.6,
    Tppd0=0.05,
    Tppq0=0.076,
    H=2.7,
    D=1.0,
    Xd=1.11,
    Xq=0.74,
    Xpd=0.35,
    Xppd=0.285,
    Xppq=0.285,
    Xl=0.21,
    S10=0.11,
    S12=0.4,
    V_0=1,
    angle_0=-0.1014632,
    P_0=5,
    Q_0=17.88221,
    M_b=80) annotation (Placement(transformation(extent={{-56,-22},{-4,32}})));
  Electrical.Controls.PSSE.TG.HYGOV hYGOV(
    R=0.05,
    r=0.4,
    T_r=5.0,
    T_f=0.05,
    T_g=0.5,
    VELM=0.167,
    G_MAX=0.95,
    G_MIN=0.0,
    T_w=1.42,
    A_t=1.4,
    D_turb=0.15,
    q_NL=0.08)
    annotation (Placement(transformation(extent={{-104,6},{-48,34}})));
  Electrical.Controls.PSSE.ES.ESST1A.ESST1A eSST1A(
    T_R=0.04,
    V_IMAX=0.3,
    V_IMIN=-0.3,
    T_C=2.0,
    T_B=10.0,
    T_C1=0.08,
    T_B1=0.083,
    K_A=300.0,
    T_A=0.001,
    V_AMAX=7.0,
    V_AMIN=-7.0,
    V_RMAX=5.2,
    V_RMIN=-5.2,
    K_C=0.38,
    K_F=0.0,
    T_F=1.0,
    K_LR=0.0,
    I_LR=0.0,
    V_0=1) annotation (Placement(transformation(extent={{-94,-22},{-60,4}})));
  Modelica.Blocks.Sources.Constant cte(k=0)
    annotation (Placement(transformation(extent={{-119,-33},{-109,-23}})));
  Electrical.Controls.PSSE.PSS.IEEEST.IEEEST iEEEST(
    A_1=0.0,
    A_2=0.0,
    A_3=0.0,
    A_4=0.0,
    A_5=0.0,
    A_6=0.0,
    T_1=0.0,
    T_2=0.0,
    T_3=0.0,
    T_4=0.0,
    T_5=0.94,
    T_6=0.94,
    K_S=-2.979,
    L_SMAX=0.05,
    L_SMIN=-0.05,
    V_CU=0.0,
    V_CL=0.0)
    annotation (Placement(transformation(extent={{-136,-12},{-106,8}})));
  Connectors.PwPin p annotation (Placement(transformation(rotation=0, extent={{
            100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant cte1(k=-9999)
    annotation (Placement(transformation(extent={{-119,-53},{-109,-43}})));
  Modelica.Blocks.Sources.Constant cte2(k=9999)
    annotation (Placement(transformation(extent={{-119,-69},{-109,-59}})));
equation
  connect(hYGOV.PMECH, gENSAL.PMECH) annotation (Line(
      points={{-46.6,20},{-55.9,20},{-55.9,18.5},{-55.48,18.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gENSAL.SPEED, hYGOV.SPEED) annotation (Line(
      points={{-1.92,29.3},{-6,29.3},{-6,40},{-102,40},{-102,27},{-103.3,27}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gENSAL.PMECH0, hYGOV.PMECH0) annotation (Line(
      points={{-1.92,-3.1},{-4,-3.1},{-4,44},{-104,44},{-104,13},{-103.3,13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gENSAL.XADIFD, eSST1A.XADIFD) annotation (Line(
      points={{-1.92,-19.3},{-1.92,-38},{-68,-38},{-68,-21.6019},{-69.3196,-21.6019}},

      color={0,0,127},
      smooth=Smooth.None));
  connect(p, gENSAL.p) annotation (Line(points={{110,0},{44,0},{44,5},{-1.4,5}},
        color={0,0,255}));
  connect(eSST1A.ECOMP, eSST1A.VT) annotation (Line(points={{-92.7007,-9.325},{
          -100,-9.325},{-100,-36},{-71.9,-36},{-71.9,-23.1375}}, color={0,0,127}));
  connect(gENSAL.ETERM, eSST1A.VT) annotation (Line(points={{-1.92,18.5},{0,
          18.5},{0,-36},{-71.9,-36},{-71.9,-23.1375}}, color={0,0,127}));
  connect(cte.y, eSST1A.VOTHSG2) annotation (Line(points={{-108.5,-28},{-104,-28},
          {-104,-4},{-96,-4},{-96,10},{-84.31,10},{-84.31,5.4625}}, color={0,0,
          127}));
  connect(cte2.y, eSST1A.VOEL) annotation (Line(points={{-108.5,-64},{-76.6964,
          -64},{-76.6964,-23.495}}, color={0,0,127}));
  connect(cte1.y, eSST1A.VUEL2) annotation (Line(points={{-108.5,-48},{-100,-48},
          {-100,-50},{-85.1114,-50},{-85.1114,-23.2675}}, color={0,0,127}));
  connect(eSST1A.VUEL3, eSST1A.VUEL2) annotation (Line(points={{-81.4079,-23.4462},
          {-81.4079,-30},{-85.1114,-30},{-85.1114,-23.2675}}, color={0,0,127}));
  connect(eSST1A.VUEL1, eSST1A.VOTHSG2) annotation (Line(points={{-88.9364,-23.3},
          {-88.9364,-28},{-104,-28},{-104,-4},{-96,-4},{-96,10},{-84.31,10},{-84.31,
          5.4625}}, color={0,0,127}));
  connect(gENSAL.EFD0, eSST1A.EFD0) annotation (Line(points={{-1.92,-13.9},{-8,
          -13.9},{-8,-30},{-54,-30},{-54,5.18625},{-70.6857,5.18625}}, color={0,
          0,127}));
  connect(gENSAL.EFD, eSST1A.EFD) annotation (Line(points={{-55.48,-8.5},{-52,-8.5},
          {-52,-8.9025},{-62.1857,-8.9025}}, color={0,0,127}));
  connect(iEEEST.VOTHSG, eSST1A.VOTHSG) annotation (Line(points={{-104.75,-2},{
          -102,-2},{-102,12},{-79.7929,12},{-79.7929,5.4625}}, color={0,0,127}));
  connect(iEEEST.V_S, gENSAL.PELEC) annotation (Line(points={{-135.75,-7},{-142,
          -7},{-142,-60},{16,-60},{16,-8.5},{-1.92,-8.5}}, color={0,0,127}));
  connect(iEEEST.V_CT, gENSAL.ETERM) annotation (Line(points={{-135.75,3},{-138,
          3},{-138,54},{4,54},{4,18.5},{-1.92,18.5}}, color={0,0,127}));
  annotation (
    Icon(graphics={Ellipse(extent={{-14,-42},{74,38}}, lineColor={0,0,255}),
          Line(
          points={{-2,-12},{18,8},{38,-12},{58,8}},
          color={0,0,255},
          smooth=Smooth.None),Ellipse(extent={{-100,-100},{101,100}}, lineColor
          ={0,0,255}),Text(
          extent={{-91,6},{-22,-12}},
          lineColor={0,0,255},
          textStyle={TextStyle.Italic},
          textString="GENSAL & 
STAB2A &
SCRX & 
HYGOV")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">&LT;iPSL: iTesla Power System Library&GT;</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Copyright 2015 RTE (France), AIA (Spain), KTH (Sweden) and DTU (Denmark)</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">RTE: http://www.rte-france.com/ </span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">AIA: http://www.aia.es/en/energy/</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">KTH: https://www.kth.se/en</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">DTU:http://www.dtu.dk/english</span></li>
</ul>
<p><span style=\"font-family: MS Shell Dlg 2;\">The authors can be contacted by email: info at itesla-ipsl dot org</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This package is part of the iTesla Power System Library (&QUOT;iPSL&QUOT;) .</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The iPSL is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The iPSL is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">You should have received a copy of the GNU Lesser General Public License along with the iPSL. If not, see &LT;http://www.gnu.org/licenses/&GT;.</span></p>
</html>"));
end RGroup1_1;

