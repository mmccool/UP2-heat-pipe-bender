// UP2 Heat Pipe Bender
// Developed by: Michael McCool
// Copyright 2017 
include <tols.scad>
include <smooth_model.scad>
//include <smooth_make.scad>
include <bolt_params.scad>
use <bolts.scad>

sm = 4*sm_base;

hp_mid_t = 2.18;
hp_mid_w = 8.36;
hp_end_t = 4.3;
hp_end_w = 7.25;
hp_mid_h = 50;
hp_end1_h = 35;
hp_end2_h = 55;
hp_trans_h = 3;
hp_cap_h = 5;
hp_cap_r = 3/2;

bend_m = 4; // minimum is 3
bend_r = bend_m*hp_end_t; 
bend_sm = 10*sm;

body_w = 12;
body_d = 10;

case_h = 99;
clamp_sw = 10;
clamp_w = body_w + 2*clamp_sw;

hp_sm = 4*sm;

module hp (t=0) {
  // end 1 cap
  translate([0,0,-hp_end1_h-hp_trans_h-hp_cap_h]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,hp_cap_h]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,hp_cap_h]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
    cylinder(r=hp_cap_r,h=hp_cap_h+eps,$fn=hp_sm);
  }
  // end 1 (short end)
  translate([0,0,-hp_end1_h-hp_trans_h]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2+t,h=hp_end1_h,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2+t,h=hp_end1_h,$fn=hp_sm);
  }
  // transition 1
  translate([0,0,-hp_trans_h-eps]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
    translate([-hp_mid_w/2+hp_mid_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_mid_t/2+t,h=eps,$fn=hp_sm);
    translate([ hp_mid_w/2-hp_mid_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_mid_t/2+t,h=eps,$fn=hp_sm);
  }
  // midsection
  translate([0,0,0]) hull() {
    translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2+t,h=hp_mid_h,$fn=hp_sm);
    translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2+t,h=hp_mid_h,$fn=hp_sm);
  }
  // transition 2
  translate([0,0,hp_mid_h-eps]) hull() {
    translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2+t,h=eps,$fn=hp_sm);
    translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2+t,h=eps,$fn=hp_sm);
    translate([-hp_end_w/2+hp_end_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
  }
  // end 2 (long end)
  translate([0,0,hp_mid_h+hp_trans_h]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2+t,h=hp_end2_h,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2+t,h=hp_end2_h,$fn=hp_sm);
  }
  // end 2 cap
  translate([0,0,hp_mid_h+hp_trans_h+hp_end2_h-eps]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,-eps]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,-eps]) 
      cylinder(r=hp_end_t/2+t,h=eps,$fn=hp_sm);
    cylinder(r=hp_cap_r,h=hp_cap_h,$fn=hp_sm);
  }
}

module body () {
  difference() {
    union() {
      hull() {
        translate([0,bend_r,-hp_trans_h])
          rotate([0,90,0])
            translate([0,0,-body_w/2]) 
              cylinder(r=bend_r,h=body_w,$fn=bend_sm);
        translate([0,bend_r,-hp_trans_h-bend_r+case_h-hp_end_t])
          rotate([0,90,0])
            translate([0,0,-body_w/2]) 
              cylinder(r=bend_r,h=body_w,$fn=bend_sm);
      }
      difference() {
        hull() {
          translate([-clamp_w/2,-body_d,-hp_trans_h]) 
            cube([clamp_w,2*body_d,hp_mid_h+2*hp_trans_h]);
          translate([-body_w/2-1,0,-hp_trans_h]) 
            cube([body_w+2,2*bend_r,hp_mid_h+2*hp_trans_h]);
        }
        hull() {
          translate([0,bend_r,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,-clamp_w/2-1]) 
                cylinder(r=bend_r,h=clamp_w+2,$fn=bend_sm);
          translate([0,2.1*bend_r,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,-clamp_w/2-1]) 
                cylinder(r=bend_r,h=clamp_w+2,$fn=bend_sm);
        }
      }
    }
    hull() {
      hp(t=tol);
      translate([0,-50,0]) hp(t=tol);
    }
  }
}


module assembly () {
  color([1,0,0,1]) hp();
  body();
}

assembly();