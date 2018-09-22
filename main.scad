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
hp_end2_h = 50;
hp_trans_h = 3;
hp_cap_h = 5;
hp_cap_r = 3/2;
hp_sm = 4*sm;

bend_m = 4; // minimum is 3
bend_r = bend_m*hp_end_t;
bend_e = 3;
bend_R = bend_r + bend_e; 
bend_sm = 10*sm;

body_w = 12;
body_d = 10;

case_h = 99;
clamp_sw = 10;
clamp_w = body_w + 2*clamp_sw;
clamp_bs = 30;
clamp_br = m3_hole_radius;
clamp_cr = m3_cap_radius;
clamp_nr = m3_nut_radius;
clamp_bt = 3;

bearing_R = 8/2;
bearing_r = 4/2;
bearing_h = 3;
bearing_fr = 9.2/2;
bearing_fh = 0.55;
bearing_sm = 10*sm;

bore_r = bearing_r + 1;

race_springback = 3;

module hp (t=0,e=0) {
  // end 1 cap
  hull() {
    translate([0,0,-hp_end1_h-hp_trans_h-hp_cap_h]) hull() {
      translate([-hp_end_w/2+hp_end_t/2,0,hp_cap_h]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      translate([ hp_end_w/2-hp_end_t/2,0,hp_cap_h]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      cylinder(r=hp_cap_r,h=hp_cap_h+eps,$fn=hp_sm);
    }
    if (e != 0) translate([0,e,0]) {
      translate([0,0,-hp_end1_h-hp_trans_h-hp_cap_h]) hull() {
        translate([-hp_end_w/2+hp_end_t/2,0,hp_cap_h]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
        translate([ hp_end_w/2-hp_end_t/2,0,hp_cap_h]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
        cylinder(r=hp_cap_r,h=hp_cap_h+eps,$fn=hp_sm);
      }
    }
  }
  // end 1 (short end)
  hull() {
    translate([0,0,-hp_end1_h-hp_trans_h]) hull() {
      translate([-hp_end_w/2+hp_end_t/2,0,0]) 
        cylinder(r=hp_end_t/2+t,h=hp_end1_h,$fn=hp_sm);
      translate([ hp_end_w/2-hp_end_t/2,0,0]) 
        cylinder(r=hp_end_t/2+t,h=hp_end1_h,$fn=hp_sm);
    }
    if (e != 0) translate([0,e,0]) {
      translate([0,0,-hp_end1_h-hp_trans_h]) hull() {
        translate([-hp_end_w/2+hp_end_t/2,0,0]) 
          cylinder(r=hp_end_t/2+t,h=hp_end1_h,$fn=hp_sm);
        translate([ hp_end_w/2-hp_end_t/2,0,0]) 
          cylinder(r=hp_end_t/2+t,h=hp_end1_h,$fn=hp_sm);
      }
    }
  }
  // transition 1
  hull() {
    translate([0,0,-hp_trans_h-tol]) hull() {
      translate([-hp_end_w/2+hp_end_t/2,0,0]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      translate([ hp_end_w/2-hp_end_t/2,0,0]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      translate([-hp_mid_w/2+hp_mid_t/2,0,hp_trans_h+tol]) 
        cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
      translate([ hp_mid_w/2-hp_mid_t/2,0,hp_trans_h+tol]) 
        cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
    }
    if (e != 0) translate([0,e,0]) {
      translate([0,0,-hp_trans_h-tol]) hull() {
        translate([-hp_end_w/2+hp_end_t/2,0,0]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
        translate([ hp_end_w/2-hp_end_t/2,0,0]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
        translate([-hp_mid_w/2+hp_mid_t/2,0,hp_trans_h+tol]) 
          cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
        translate([ hp_mid_w/2-hp_mid_t/2,0,hp_trans_h+tol]) 
          cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
      }
    }
  }
  // midsection
  hull() {
    translate([0,0,0]) hull() {
      translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
        cylinder(r=hp_mid_t/2+t,h=hp_mid_h,$fn=hp_sm);
      translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
        cylinder(r=hp_mid_t/2+t,h=hp_mid_h,$fn=hp_sm);
    }
    if (e != 0) translate([0,e,0]) {
      translate([0,0,0]) hull() {
        translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
          cylinder(r=hp_mid_t/2+t,h=hp_mid_h,$fn=hp_sm);
        translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
          cylinder(r=hp_mid_t/2+t,h=hp_mid_h,$fn=hp_sm);
      }
    }
  }
  // transition 2
  hull() {
    translate([0,0,hp_mid_h-tol]) hull() {
      translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
        cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
      translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
        cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
      translate([-hp_end_w/2+hp_end_t/2,0,hp_trans_h+tol]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      translate([ hp_end_w/2-hp_end_t/2,0,hp_trans_h+tol]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
    }
    if (e != 0) translate([0,e,0]) {
      translate([0,0,hp_mid_h-tol]) hull() {
        translate([-hp_mid_w/2+hp_mid_t/2,0,0]) 
          cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
        translate([ hp_mid_w/2-hp_mid_t/2,0,0]) 
          cylinder(r=hp_mid_t/2+t,h=tol,$fn=hp_sm);
        translate([-hp_end_w/2+hp_end_t/2,0,hp_trans_h+tol]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
        translate([ hp_end_w/2-hp_end_t/2,0,hp_trans_h+tol]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      }
    }
  }
  // end 2 (long end)
  hull() {
    translate([0,0,hp_mid_h+hp_trans_h]) hull() {
      translate([-hp_end_w/2+hp_end_t/2,0,0]) 
        cylinder(r=hp_end_t/2+t,h=hp_end2_h,$fn=hp_sm);
      translate([ hp_end_w/2-hp_end_t/2,0,0]) 
        cylinder(r=hp_end_t/2+t,h=hp_end2_h,$fn=hp_sm);
    }
    if (e != 0) translate([0,e,0]) {
      translate([0,0,hp_mid_h+hp_trans_h]) hull() {
        translate([-hp_end_w/2+hp_end_t/2,0,0]) 
          cylinder(r=hp_end_t/2+t,h=hp_end2_h,$fn=hp_sm);
        translate([ hp_end_w/2-hp_end_t/2,0,0]) 
          cylinder(r=hp_end_t/2+t,h=hp_end2_h,$fn=hp_sm);
      }
    }
  }
  // end 2 cap
  hull() {
    translate([0,0,hp_mid_h+hp_trans_h+hp_end2_h-tol]) hull() {
      translate([-hp_end_w/2+hp_end_t/2,0,-tol]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      translate([ hp_end_w/2-hp_end_t/2,0,-tol]) 
        cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
      cylinder(r=hp_cap_r,h=hp_cap_h,$fn=hp_sm);
    }
    if (e != 0) translate([0,e,0]) {
      translate([0,0,hp_mid_h+hp_trans_h+hp_end2_h-tol]) hull() {
        translate([-hp_end_w/2+hp_end_t/2,0,-tol]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
        translate([ hp_end_w/2-hp_end_t/2,0,-tol]) 
          cylinder(r=hp_end_t/2+t,h=tol,$fn=hp_sm);
        cylinder(r=hp_cap_r,h=hp_cap_h,$fn=hp_sm);
      }
    }
  }
}

race_sm = 6*sm;
module race (t=0,e=10,E=10,h=hp_trans_h,sb=race_springback) {
  intersection() {
    rotate([0,90,0]) 
      rotate_extrude($fn=race_sm) {
        translate([bend_r,0]) hull() {
          translate([0,-hp_end_w/2+hp_end_t/2]) 
            circle(r=hp_end_t/2+t,$fn=hp_sm);
          translate([0, hp_end_w/2-hp_end_t/2]) 
            circle(r=hp_end_t/2+t,$fn=hp_sm);
          if (e != 0) translate([e,0]) {
            translate([0,-hp_end_w/2+hp_end_t/2]) 
              circle(r=hp_end_t/2+t,$fn=hp_sm);
            translate([0, hp_end_w/2-hp_end_t/2]) 
              circle(r=hp_end_t/2+t,$fn=hp_sm);
          }
        }
      }
    translate([-hp_end_w/2-1,-(bend_r+hp_end_t/2+e+1),-(bend_r+hp_end_t/2+e+1)-h]) 
      cube([hp_end_w+2,bend_r+hp_end_t/2+e+1,bend_r+hp_end_t/2+e+1]);
  }
  translate([0,-tol,-bend_r]) 
    hull() {
      rotate([-90,0,0]) 
        linear_extrude(E) {
          hull() {
            translate([-hp_end_w/2+hp_end_t/2,0]) 
              circle(r=hp_end_t/2+t,$fn=hp_sm);
            translate([ hp_end_w/2-hp_end_t/2,0]) 
              circle(r=hp_end_t/2+t,$fn=hp_sm);
            if (e != 0) translate([0,e]) {
              translate([-hp_end_w/2+hp_end_t/2,0]) 
                circle(r=hp_end_t/2+t,$fn=hp_sm);
              translate([ hp_end_w/2-hp_end_t/2,0]) 
                circle(r=hp_end_t/2+t,$fn=hp_sm);
            }
          }
        }
      rotate([-90+sb,0,0]) 
        linear_extrude(E/cos(sb)) {
          hull() {
            translate([-hp_end_w/2+hp_end_t/2,0]) 
              circle(r=hp_end_t/2+t,$fn=hp_sm);
            translate([ hp_end_w/2-hp_end_t/2,0]) 
              circle(r=hp_end_t/2+t,$fn=hp_sm);
            if (e != 0) translate([0,e]) {
              translate([-hp_end_w/2+hp_end_t/2,0]) 
                circle(r=hp_end_t/2+t,$fn=hp_sm);
              translate([ hp_end_w/2-hp_end_t/2,0]) 
                circle(r=hp_end_t/2+t,$fn=hp_sm);
            }
          }
        }
    }
}

module bearing () {
  difference() {
    union() {
      cylinder(r=bearing_R,h=bearing_h,$fn=bearing_sm);
      cylinder(r=bearing_fr,h=bearing_fh,$fn=bearing_sm);
    }
    translate([0,0,-1])
      cylinder(r=bearing_r,h=bearing_h+2,$fn=bearing_sm);
  }
}

module body () {
  difference() {
    union() {
      hull() {
        translate([0,bend_r,-hp_trans_h])
          rotate([0,90,0])
            translate([0,0,-body_w/2]) 
              cylinder(r=bend_R,h=body_w,$fn=bend_sm);
        translate([0,bend_r,-hp_trans_h-2*bend_r+case_h-hp_end_t])
          rotate([0,90,0])
            translate([0,0,-body_w/2]) 
              cylinder(r=bend_R,h=body_w,$fn=bend_sm);
        translate([-body_w/2,bend_r,-bend_r-hp_trans_h-hp_end_t/2])
          cube([body_w,bend_R,case_h]);
      }
      difference() {
        // clamp anvil
        hull() {
          //translate([-clamp_w/2,-body_d,-hp_trans_h]) 
          //  cube([clamp_w,2*body_d,-2*bend_r+case_h-hp_end_t]);
          hull() {
            translate([-clamp_w/4,-body_d,clamp_w/4-hp_trans_h])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
            translate([ clamp_w/4,-body_d,clamp_w/4-hp_trans_h])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
            translate([-clamp_w/4,-body_d,-clamp_w/4-hp_trans_h-2*bend_r+case_h-hp_end_t])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
            translate([ clamp_w/4,-body_d,-clamp_w/4-hp_trans_h-2*bend_r+case_h-hp_end_t])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
          }
          translate([-body_w/2-1,0,-hp_trans_h]) 
            cube([body_w+2,bend_r+bend_R,-2*bend_r+case_h-hp_end_t]);
        }
        // cutouts for benders
        hull() {
          translate([-eps,bend_r,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,-clamp_w/2-1]) 
                cylinder(r2=bend_r,r1=bend_r+(clamp_w/2-body_w/2),
                         h=clamp_w/2-body_w/2+1,$fn=bend_sm);
          translate([-eps,2.1*bend_R,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,-clamp_w/2-1]) 
                cylinder(r=bend_r,h=clamp_w/2-body_w/2+1,$fn=bend_sm);
        }
        translate([-eps,0,-2*bend_r+case_h-hp_end_t]) hull() {
          translate([0,bend_r,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,-clamp_w/2-1]) 
                cylinder(r2=bend_r,r1=bend_r+(clamp_w/2-body_w/2),
                         h=clamp_w/2-body_w/2+1,$fn=bend_sm);
          translate([-eps,2.1*bend_R,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,-clamp_w/2-1]) 
                cylinder(r=bend_r,h=clamp_w/2-body_w/2+1,$fn=bend_sm);
        }
        hull() {
          translate([-eps,bend_r,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,body_w/2]) 
                cylinder(r1=bend_r,r2=bend_r+(clamp_w/2-body_w/2),
                         h=clamp_w/2-body_w/2+1,$fn=bend_sm);
          translate([-eps,2.1*bend_R,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,body_w/2]) 
                cylinder(r=bend_r,h=clamp_w/2-body_w/2+1,$fn=bend_sm);
        }
        translate([-eps,0,-2*bend_r+case_h-hp_end_t]) hull() {
          translate([0,bend_r,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,body_w/2]) 
                cylinder(r1=bend_r,r2=bend_r+(clamp_w/2-body_w/2),
                         h=clamp_w/2-body_w/2+1,$fn=bend_sm);
          translate([-eps,2.1*bend_R,-hp_trans_h])
            rotate([0,90,0])
              translate([0,0,body_w/2]) 
                cylinder(r=bend_r,h=clamp_w/2-body_w/2+1,$fn=bend_sm);
        }
        // clamp bolt holes
        translate([-body_w/2-(clamp_w-body_w)/4,-body_d-1,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2])
          rotate([-90,0,0]) {
            cylinder(r=clamp_br,h=2*body_d+2*bend_R,$fn=bend_sm);
            translate([0,0,1+clamp_bt]) {
              cylinder(r1=clamp_br,r2=clamp_cr,h=clamp_cr-clamp_br+tol,$fn=bend_sm);
              translate([0,0,clamp_cr-clamp_br])
                cylinder(r=clamp_cr,h=2*body_d+2*bend_R,$fn=bend_sm);
            }
          }
        translate([ body_w/2+(clamp_w-body_w)/4,-body_d-1,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2])
          rotate([-90,0,0]) {
            cylinder(r=clamp_br,h=2*body_d+2*bend_R,$fn=bend_sm);
            translate([0,0,1+clamp_bt]) {
              cylinder(r1=clamp_br,r2=clamp_cr,h=clamp_cr-clamp_br+tol,$fn=bend_sm);
              translate([0,0,clamp_cr-clamp_br])
                cylinder(r=clamp_cr,h=2*body_d+2*bend_R,$fn=bend_sm);
            }
          }
        translate([-body_w/2-(clamp_w-body_w)/4,-body_d-1,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2])
          rotate([-90,0,0]) {
            cylinder(r=clamp_br,h=2*body_d+2*bend_R,$fn=bend_sm);
            translate([0,0,1+clamp_bt]) {
              cylinder(r1=clamp_br,r2=clamp_cr,h=clamp_cr-clamp_br+tol,$fn=bend_sm);
              translate([0,0,clamp_cr-clamp_br])
                cylinder(r=clamp_cr,h=2*body_d+2*bend_R,$fn=bend_sm);
            }
          }
        translate([ body_w/2+(clamp_w-body_w)/4,-body_d-1,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2])
          rotate([-90,0,0]) {
            cylinder(r=clamp_br,h=2*body_d+2*bend_R,$fn=bend_sm);
            translate([0,0,1+clamp_bt]) {
              cylinder(r1=clamp_br,r2=clamp_cr,h=clamp_cr-clamp_br+tol,$fn=bend_sm);
              translate([0,0,clamp_cr-clamp_br])
                cylinder(r=clamp_cr,h=2*body_d+2*bend_R,$fn=bend_sm);
            }
          }
      }
    }
    // heat pipe
    hp(t=tol,e=-50);
    // races
    translate([0,bend_r,-hp_trans_h])
      race(t=tol,h=0,E=bend_R+2);
    translate([0,bend_r,-hp_trans_h-2*bend_r+case_h-hp_end_t])
      rotate([0,180,0]) race(t=tol,h=0,E=bend_R+2);
    // shaft bores
    translate([0,bend_r,-hp_trans_h])
      rotate([0,90,0])
        translate([0,0,-body_w/2-1]) 
          cylinder(r=bore_r,h=body_w+2,$fn=bend_sm);
    translate([0,bend_r,-hp_trans_h-2*bend_r+case_h-hp_end_t])
      rotate([0,90,0])
        translate([0,0,-body_w/2-1]) 
          cylinder(r=bore_r,h=body_w+2,$fn=bend_sm);
    // bearing bores
    translate([0,bend_r,-hp_trans_h]) {
      rotate([0,90,0])
        translate([0,0,-body_w/2-1]) 
          cylinder(r=bearing_fr+3*tol,h=bearing_fh+tol+1,$fn=bend_sm);
      rotate([0,90,0])
        translate([0,0,-body_w/2-1]) 
          cylinder(r=bearing_R+tol,h=bearing_h+tol+1,$fn=bend_sm);
      rotate([0,90,0])
        translate([0,0,body_w/2-bearing_fh]) 
          cylinder(r=bearing_fr+3*tol,h=bearing_fh+tol+1,$fn=bend_sm);
      rotate([0,90,0])
        translate([0,0,body_w/2-bearing_h]) 
          cylinder(r=bearing_R+tol,h=bearing_h+tol+1,$fn=bend_sm);
    }
    translate([0,bend_r,-hp_trans_h-2*bend_r+case_h-hp_end_t]) {
      rotate([0,90,0])
        translate([0,0,-body_w/2-1]) 
          cylinder(r=bearing_fr+3*tol,h=bearing_fh+tol+1,$fn=bend_sm);
      rotate([0,90,0])
        translate([0,0,-body_w/2-1]) 
          cylinder(r=bearing_R+tol,h=bearing_h+tol+1,$fn=bend_sm);
      rotate([0,90,0])
        translate([0,0,body_w/2-bearing_fh]) 
          cylinder(r=bearing_fr+3*tol,h=bearing_fh+tol+1,$fn=bend_sm);
      rotate([0,90,0])
        translate([0,0,body_w/2-bearing_h]) 
          cylinder(r=bearing_R+tol,h=bearing_h+tol+1,$fn=bend_sm);
    }
  }
}


module assembly () {
  //color([1,0,0,1]) hp();
  body();
}

//race();
//bearing();
assembly();