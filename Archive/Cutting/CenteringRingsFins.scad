include <BOSL/constants.scad>
use <BOSL/shapes.scad>

$fn=64;
bool_allowance=0.01;
fillet_radius=0;
InMm=25.4;

DrawRing=true;
CutNotches=true;
// Interstate Plastics, 1/2-inch G10
FiberglassThicknessRing=0.5*InMm;
FiberglassThicknessFin=0.25*InMm;
CenteringRingThickness = FiberglassThicknessRing;
FinThickness = FiberglassThicknessFin;


// Measured, Nov 2024
BodyID=6*InMm;
MountOD=3.065*InMm;
// Laser cutter kerf, measured 0.175
LaserKerf=0.175;
// CNC cutter kerf, 0.175
CNCKerf=0.125;
Kerf=CNCKerf;
// Centering ring measurements
RingZ=CenteringRingThickness;
FinZ=FinThickness;
HoleZ=CenteringRingThickness;
RingWidth=(BodyID-MountOD)/2;
NotchWidth=FinZ;
NotchLength=RingWidth/2;
RingNotchBase=MountOD/2+NotchLength;
RingNotches=[0,90,180,270];
// Fin measurements
FinRootChord=16*InMm;
FinTipChord=8*InMm;
FinHeight=6*InMm;
FinSweep=5*InMm;
FinTabLength=16*InMm;
FinTabHeight=1.512*InMm;
MiddleCenteringRingX=1.95*InMm;
FinOutline=[[0,0],
            [FinSweep,FinHeight],
            [FinSweep+FinTipChord,FinHeight],
            [FinRootChord,0],
            [FinRootChord,-NotchLength],
            [FinRootChord-CenteringRingThickness,-NotchLength],
            [FinRootChord-CenteringRingThickness,-RingWidth],
            [MiddleCenteringRingX+CenteringRingThickness,-RingWidth],
            [MiddleCenteringRingX+CenteringRingThickness,-NotchLength],
            [MiddleCenteringRingX,-NotchLength],
            [MiddleCenteringRingX,-RingWidth],
            [0,-RingWidth]];

offset(delta=Kerf/2) {
    projection() {
        if(DrawRing) {
            CenteringRing();
        } else {
            Fin();
        }
    }
}
module CenteringRing() {
    difference() {
        // Ring
        cyl(h=RingZ,d=BodyID);
        // Motor mount hole
        cyl(h=HoleZ,d=MountOD);
        if(CutNotches) {
            for(i=RingNotches) rotate(i) 
                translate([RingNotchBase,0,0])
                    cuboid([NotchLength,NotchWidth,RingZ],align=V_RIGHT);
        }
    }
}

module Fin() {
    // Fin
        linear_extrude(height=FinThickness) polygon(FinOutline);
}
