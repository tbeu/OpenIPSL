within OpenIPSL.Electrical.ThreePhase.Branches.Lines;
model Line_2Ph "Two-phase line modeled as a PI-equivalent device."
  extends Branches.BaseClasses.baseLine;

  OpenIPSL.Interfaces.PwPin Ain
    annotation (Placement(transformation(extent={{-140,35},{-120,55}})));
  OpenIPSL.Interfaces.PwPin Bin
    annotation (Placement(transformation(extent={{-140,-55},{-120,-35}})));
  OpenIPSL.Interfaces.PwPin Aout
    annotation (Placement(transformation(extent={{120,35},{140,55}})));
  OpenIPSL.Interfaces.PwPin Bout
    annotation (Placement(transformation(extent={{120,-55},{140,-35}})));

  parameter SI.PerUnit Gseraa=0 "Element (1,1) in series conductance matrix" annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Bseraa=-10 "Element (1,1) in series susceptance matrix"
    annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Gserab=0 "Element (1,2) in series conductance matrix" annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Bserab=0 "Element (1,2) in series susceptance matrix" annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Gserbb=0 "Element (2,2) in series conductance matrix" annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Bserbb=-10 "Element (2,2) in series susceptance matrix"
    annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Bshtaa=0 "Element (1,1) in shunt half susceptance matrix" annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Bshtab=0 "Element (1,2) in shunt half susceptance matrix" annotation (Dialog(group="Power flow data"));
  parameter SI.PerUnit Bshtbb=0 "Element (2,2) in shunt half susceptance matrix" annotation (Dialog(group="Power flow data"));

  //Writing the Y_ser matrix for the pi model
protected
  parameter Real[4, 4] Y_ser=[Gseraa, -Bseraa, Gserab, -Bserab; Bseraa, Gseraa,
      Bserab, Gserab; Gserab, -Bserab, Gserbb, -Bserbb; Bserab, Gserab, Bserbb,
      Gserbb];

  //Writing the Y_sht matrix for the pi model
  parameter Real[4, 4] Y_sht=[zero, -Bshtaa, zero, -Bshtab; Bshtaa, zero,
      Bshtab, zero; zero, -Bshtab, zero, -Bshtbb; Bshtab, zero, Bshtbb, zero];

  //Calculating the parameters for the Transformer
  //Writing the matrix A (Yser1+Yshtk)
  parameter Real[4, 4] A=Y_ser + Y_sht;

  //Writing the matrix B (-Yser1)
  parameter Real[4, 4] B=-Y_ser;

  // Writing matrix for voltages (in and out)
  Real[4, 1] Vin=[Ain.vr; Ain.vi; Bin.vr; Bin.vi];
  Real[4, 1] Vout=[Aout.vr; Aout.vi; Bout.vr; Bout.vi];
  // Writing matrix for currents (in and out)
  Real[4, 1] Iin=[Ain.ir; Ain.ii; Bin.ir; Bin.ii];
  Real[4, 1] Iout=[Aout.ir; Aout.ii; Bout.ir; Bout.ii];

equation
  // Equations according to pi model
  Iin = A*Vin + B*Vout;
  Iout = B*Vin + A*Vout;

  annotation (
    Icon(coordinateSystem(
        extent={{-140,-100},{140,100}},
        preserveAspectRatio=true,
        initialScale=0.1), graphics={Line(points={{-90,0},{-110,45},{-130,45}},
          color={0,0,255}),Line(points={{-90,0},{-110,-45},{-130,-45}}, color={
          0,0,255}),Line(points={{90,0},{110,45},{130,45}}, color={0,0,255}),
          Line(points={{90,0},{110,-45},{130,-45}}, color={0,0,255})}),
    Diagram(coordinateSystem(
        extent={{-140,-100},{140,100}},
        preserveAspectRatio=true,
        initialScale=0.1)),
    Documentation(info="<html>
<p>This model was design to represent two-phase power line, modeled as a pi-element.</p> 
<p>The user should input the series conductance and susceptance, and half shunt susceptance (line charging). All in matrix form, since the model allows the representation of unbalanced lines.
Series conductance (Gser) matrix is considered to have the following structure:</p>
<p><b>[Gseraa</b>, <b>Gserab</b>; </p>
<p><b> Gserab</b>, <b>Gserbb</b>] </p>
<p>Series susceptance (Bser) matrix is considered to have the following structure:</p>
<p><b>[Bseraa</b>, <b>Bserab</b>; </p>
<p><b> Bserab</b>, <b>Bserbb</b>] </p>
<p>The series admittance matrix is <b>Yser = Gser+jBser</b>. Each of the two shunt susceptance (Bsht) matrices is considered to have the following structure:</p>
<p><b>[Bshtaa</b>, <b>Bshtab</b>; </p>
<p><b> Bshtab</b>, <b>Bshtbb</b>] </p>
<p>Based on this set of parameters, the pi-equivalent impedance matrices are calculated and the power line equation is assembled.</p>
</html>"));
end Line_2Ph;
