// Parameters
outer_d   = 20.3;   // mm
thickness = 1;    // mm
height    = 100;   // mm
inner_d   = outer_d - 2*thickness;  // 16 mm
bottom_t  = 2;    // mm
pinhole_size = 1;
// Hollow tube

module tube() {
  difference() {
//      this is the main tube
    cylinder(h = height, d = outer_d, $fn = 128);
    translate([0, 0, -0.05])
      cylinder(h = height + 0.1, d = inner_d, $fn = 128);Í
  }
}Í

// Bottom cap with 1 mm pinhole
module bottom_cap_with_pinhole() {
  difference() {
    cylinder(h = bottom_t, d = inner_d, $fn = 128);     // the cap
    translate([0, 0, -0.05])                             // small Z fudge
      cylinder(h = bottom_t + 0.1, d = pinhole_size, $fn = 48);     // Ø1 mm hole
  }
}

// Assembly
union() {
  tube();
  bottom_cap_with_pinhole();
}
