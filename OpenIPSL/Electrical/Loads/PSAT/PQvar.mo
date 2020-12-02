within OpenIPSL.Electrical.Loads.PSAT;
model PQvar "Equations come from the mathematical separation in between reals and imaginary of S=P+jQ=UI*"
  extends BaseClasses.baseLoad;
  parameter Types.Time t_start_1=1
    "Start time of first load variation"
    annotation (Dialog(group="Variation 1"));
  parameter Types.Time t_end_1=2
    "End time of first load variation"
    annotation (Dialog(group="Variation 1"));
  parameter Types.ActivePower dP1=0
    "First active load variation" annotation (Dialog(group="Variation 1"));
  parameter Types.ReactivePower dQ1=0
    "First reactive load variation"
    annotation (Dialog(group="Variation 1"));
  parameter Types.Time t_start_2=2
    "Start time of second Load variation"
    annotation (Dialog(group="Variation 2"));
  parameter Types.Time t_end_2=3
    "End time of second load variation"
    annotation (Dialog(group="Variation 2"));
  parameter Types.ActivePower dP2=0
    "Second active load variation"
    annotation (Dialog(group="Variation 2"));
  parameter Types.ReactivePower dQ2=0
    "Second reactive load variation"
    annotation (Dialog(group="Variation 2"));
  parameter Types.PerUnit Vmax=1.2 "maximum voltage"
    annotation (Evaluate=true, Dialog(tab="To Be Implemented"));
  parameter Types.PerUnit Vmin=0.8 "minimum voltage"
    annotation (Evaluate=true, Dialog(tab="To Be Implemented"));
  parameter Boolean forcePQ=true
    "force 'constant' PQ-load, false may cause simulation problems"
    annotation (
    Evaluate=true,
    choices(checkBox=true),
    Dialog(tab="To Be Implemented"));
protected
  Types.PerUnit Pd(start=P_0/S_b) "active
  power demand";
  Types.PerUnit Qd(start=Q_0/S_b) "reactive power demand";
equation
  // forcePQ=false needs better implementation
  if forcePQ or initial() then
    P = Pd;
    Q = Qd;
  elseif noEvent(v > Vmax) then
    P = Pd*v^2/(Vmax^2)/S_b;
    Q = Qd*v^2/(Vmax^2)/S_b;
  elseif noEvent(v < Vmin) then
    P = Pd*v^2/Vmin^2/S_b;
    Q = Qd*v^2/(Vmin^2)/S_b;
  else
    P = Pd;
    Q = Qd;
  end if;
  if time >= t_start_1 and time < t_end_1 then
    Pd = (P_0 + dP1)/S_b;
    Qd = (Q_0 + dQ1)/S_b;
  elseif time >= t_start_2 and time < t_end_2 then
    Pd = (P_0 + dP2)/S_b;
    Qd = (Q_0 + dQ2)/S_b;
  else
    Pd = P_0/S_b;
    Qd = Q_0/S_b;
  end if;
end PQvar;
