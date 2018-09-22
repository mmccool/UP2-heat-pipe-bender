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
bend_e = 5;
bend_R = bend_r + bend_e; 
bend_sm = 10*sm;

body_w = 12;
body_d = 10;

case_h = 99;
clamp_sw = 8;
clamp_w = body_w + 2*clamp_sw;
clamp_bs = 25;
clamp_br = m3_hole_radius;
clamp_cr = m3_cap_radius + 2*tol;
clamp_nr = m3_nut_radius + 2*tol;
clamp_bt = 3;
clamp_tt = clamp_bt + 3;
clamp_ct = 1;
clamp_tol = 1;

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
module race_roller(t=0,e=10) {
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
}
module race (t=0,e=10,E=10,h=hp_trans_h,sb=race_springback) {
  intersection() {
    race_roller(t=t,e=e);
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

anvil_c = 12;
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
            translate([-clamp_w/4,-body_d,clamp_w/4-hp_trans_h+anvil_c])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
            translate([ clamp_w/4,-body_d,clamp_w/4-hp_trans_h+anvil_c])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
            translate([-clamp_w/4,-body_d,-clamp_w/4-hp_trans_h-2*bend_r+case_h-hp_end_t-anvil_c])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
            translate([ clamp_w/4,-body_d,-clamp_w/4-hp_trans_h-2*bend_r+case_h-hp_end_t-anvil_c])
              rotate([-90,0,0]) 
                cylinder(r=clamp_w/4,h=2*body_d,$fn=bend_sm);
          }
          translate([-body_w/2-1,0,-hp_trans_h+anvil_c]) 
            cube([body_w+2,bend_r+bend_R,-2*bend_r+case_h-hp_end_t-2*anvil_c]);
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

arm_tol = 0.5;
module body_roller (t=tol,at=arm_tol) {
  ah = hp_end_w-2*at;
  difference() { 
    union() {
      translate([-ah/2,-bend_r,-hp_trans_h])
        rotate([0,90,0])
          cylinder(r=bend_r,h=ah,$fn=bend_sm);
      translate([-body_w/2,-bend_r,-hp_trans_h])
        rotate([0,90,0])
          cylinder(r=bend_r-bend_e-2*tol,h=body_w,$fn=bend_sm);
    }
    translate([0,-bend_r,-hp_trans_h]) {
      // race
      race_roller(t=t,e=10);
      // shaft bore
      rotate([0,90,0])
        translate([0,0,-body_w/2-1]) 
          cylinder(r=bore_r,h=body_w+2,$fn=bend_sm);
      // bearing body
      rotate([0,90,0])
        translate([0,0,body_w/2-bearing_h-tol])
          cylinder(r=bearing_R+tol,h=bearing_h+1,$fn=bend_sm);
      // bearing flanges
      rotate([0,90,0])
        translate([0,0,body_w/2-bearing_fh-tol])
          cylinder(r=bearing_fr+3*tol,h=bearing_fh+1,$fn=bend_sm);
    }
  }
}

module half_roller (t=tol,at=arm_tol) {
  intersection() {
    body_roller(t=t,at=at);
    translate([0,-bend_r,-hp_trans_h])
      rotate([0,90,0])
        cylinder(r=bend_R+1,h=body_w/2+1,$fn=bend_sm);
  }
}

module roller(t=tol,at=arm_tol) {
  union() {
    translate([-eps,0,0]) half_roller(t=t,at=at);
    translate([eps,0,-hp_trans_h]) 
      rotate([0,180,0]) 
        translate([0,0,hp_trans_h]) 
          half_roller(t=t,at=at);
  }
}

clamp_trunc = 8;
module clamp () {
  difference() {
    union() {
      hull() {
        // base
        translate([-clamp_w/4,-body_d-clamp_tt-clamp_ct,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2+3])
          rotate([-90,0,0]) 
            cylinder(r=clamp_w/4,h=clamp_tt,$fn=bend_sm);
        translate([ clamp_w/4,-body_d-clamp_tt-clamp_ct,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2+3])
          rotate([-90,0,0]) 
            cylinder(r=clamp_w/4,h=clamp_tt,$fn=bend_sm);
        translate([-clamp_w/4,-body_d-clamp_tt-clamp_ct,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2-3])
          rotate([-90,0,0]) 
            cylinder(r=clamp_w/4,h=clamp_tt,$fn=bend_sm);
        translate([ clamp_w/4,-body_d-clamp_tt-clamp_ct,
                   -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2-3])
          rotate([-90,0,0]) 
            cylinder(r=clamp_w/4,h=clamp_tt,$fn=bend_sm);
      }
      // insert
      translate([-hp_mid_w/2+clamp_tol,-body_d-clamp_tt-clamp_ct,clamp_trunc-hp_trans_h])
        cube([hp_mid_w-2*clamp_tol,body_d+clamp_tt+clamp_ct,
              -2*bend_r+case_h-hp_end_t-2*clamp_trunc]);
    }
    // rollers
    roller(t=-clamp_tol,at=-tol);
    translate([0,0,-2*bend_r+case_h-hp_end_t]) roller(t=-clamp_tol,at=-tol);
    // bolt holes
    translate([-body_w/2-(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2])
      rotate([-90,0,0]) 
        cylinder(r=clamp_br,h=clamp_tt+2,$fn=bend_sm);
    translate([ body_w/2+(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2])
      rotate([-90,0,0]) 
        cylinder(r=clamp_br,h=clamp_tt+2,$fn=bend_sm);
    translate([-body_w/2-(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2])
      rotate([-90,0,0]) 
        cylinder(r=clamp_br,h=clamp_tt+2,$fn=bend_sm);
    translate([ body_w/2+(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2])
      rotate([-90,0,0]) 
        cylinder(r=clamp_br,h=clamp_tt+2,$fn=bend_sm);
    // nut retainers
/* 
    translate([-body_w/2-(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2])
      rotate([-90,0,0]) 
        rotate(-15) cylinder(r=clamp_nr,h=3+1,$fn=6);
    translate([ body_w/2+(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2-clamp_bs/2])
      rotate([-90,0,0]) 
        rotate(15) cylinder(r=clamp_nr,h=3+1,$fn=6);
    translate([-body_w/2-(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2])
      rotate([-90,0,0]) 
        rotate(15) cylinder(r=clamp_nr,h=3+1,$fn=6);
    translate([ body_w/2+(clamp_w-body_w)/4,-body_d-clamp_tt-clamp_ct-1,
               -hp_trans_h-(2*bend_r-case_h+hp_end_t)/2+clamp_bs/2])
      rotate([-90,0,0]) 
        rotate(-15) cylinder(r=clamp_nr,h=3+1,$fn=6);
*/
    // heat pipe
    hp(t=tol,e=50);
  }
}

arm_len = 100;
arm_t = 5;
arm_r = bend_r - bend_e - 2;
arm_h_tol = 1;
arm_h_r1 = bearing_r + 1;
arm_h_r2 = arm_r;
module half_arm () {
  difference() {
    union() {
      translate([body_w/2+arm_h_tol,bend_r,-hp_trans_h]) hull() {
        rotate([0,90,0]) cylinder(r=arm_r,h=arm_t,$fn=bend_sm);
        translate([0,-arm_len,0]) rotate([0,90,0]) cylinder(r=arm_r,h=arm_t,$fn=bend_sm);
      }
      translate([body_w/2,bend_r,-hp_trans_h])
        rotate([0,90,0]) cylinder(r1=arm_h_r1,r2=arm_h_r2,h=arm_t+arm_h_tol-tol,$fn=bend_sm);
      translate([body_w/2,-bend_r,-hp_trans_h])
        rotate([0,90,0]) cylinder(r1=arm_h_r1,r2=arm_h_r2,h=arm_t+arm_h_tol-tol,$fn=bend_sm);
      translate([0,bend_r-arm_len,-hp_trans_h]) 
        rotate([0,90,0]) cylinder(r=arm_r,h=body_w/2+arm_t+arm_h_tol-tol,$fn=bend_sm);
    }
    translate([body_w/2-1,bend_r,-hp_trans_h])
      rotate([0,90,0]) cylinder(r=bearing_r,h=arm_t+arm_h_tol+2,$fn=bend_sm);
    translate([body_w/2-1,-bend_r,-hp_trans_h])
      rotate([0,90,0]) cylinder(r=bearing_r,h=arm_t+arm_h_tol+2,$fn=bend_sm);
    translate([-1,bend_r-arm_len,-hp_trans_h]) 
      rotate([0,90,0]) cylinder(r=bearing_r,h=body_w/2+arm_t+arm_h_tol+2,$fn=bend_sm);
  }
}

module arm() {
  translate([-eps,0,0]) half_arm();
  translate([eps,0,-hp_trans_h]) 
      rotate([0,180,0]) 
        translate([0,0,hp_trans_h]) 
          half_arm();
}

module assembly () {
  color([1,0,0,1]) hp();
  body();
  clamp();
  roller();
  arm();
}

// TEST
//hp();
//race();
//bearing();
//arm();

// PRINT
//body();
//clamp();
//half_roller();
//half_arm();

// VIEW
assembly();