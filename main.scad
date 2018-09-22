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

hp_sm = 4*sm;

module hp () {
  // end 1 cap
  translate([0,0,-hp_end1_h-hp_trans_h-hp_cap_h]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,hp_cap_h]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,hp_cap_h]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
    cylinder(r=hp_cap_r,h=hp_cap_h+eps,$fn=hp_sm);
  }
  // end 1 (short end)
  translate([0,0,-hp_end1_h-hp_trans_h]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2,h=hp_end1_h,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2,h=hp_end1_h,$fn=hp_sm);
  }
  // transition 1
  translate([0,0,-hp_trans_h-eps]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
    translate([-hp_mid_w/2+hp_mid_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_mid_t/2,h=eps,$fn=hp_sm);
    translate([ hp_mid_w/2-hp_mid_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_mid_t/2,h=eps,$fn=hp_sm);
  }
  // midsection
  translate([0,0,0]) hull() {
    translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2,h=hp_mid_h,$fn=hp_sm);
    translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2,h=hp_mid_h,$fn=hp_sm);
  }
  // transition 2
  translate([0,0,hp_mid_h-eps]) hull() {
    translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2,h=eps,$fn=hp_sm);
    translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
      cylinder(r=hp_mid_t/2,h=eps,$fn=hp_sm);
    translate([-hp_end_w/2+hp_end_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,hp_trans_h+eps]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
  }
  // end 2 (long end)
  translate([0,0,hp_mid_h+hp_trans_h]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2,h=hp_end2_h,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,0]) 
      cylinder(r=hp_end_t/2,h=hp_end2_h,$fn=hp_sm);
  }
  // end 2 cap
  translate([0,0,hp_mid_h+hp_trans_h+hp_end2_h-eps]) hull() {
    translate([-hp_end_w/2+hp_end_t/2,0,-eps]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
    translate([ hp_end_w/2-hp_end_t/2,0,-eps]) 
      cylinder(r=hp_end_t/2,h=eps,$fn=hp_sm);
    cylinder(r=hp_cap_r,h=hp_cap_h,$fn=hp_sm);
  }
}

module assembly () {
  color([1,0,0,1]) hp();
}

assembly();