// Parameters
outer_d    = 20.1; // mm
thickness  = 2;    // mm
height     = 50;   // mm
inner_d    = 16.1; // 16.1 mm
bottom_t   = 6;    // mm
pinhole_size = 2;

// Handle parameters
handle_length = 20;   // mm - how far the handle extends
handle_width = 6;     // mm - width of the handle
handle_thickness = 3; // mm - thickness of the handle
handle_hole_d = 4;    // mm - diameter for loop handle hole

// Bottom cap with 2 mm pinhole
module bottom_cap_with_pinhole() {
  difference() {
    cylinder(h = bottom_t, d = inner_d, $fn = 128);      // the cap (d=16.1)
    translate([0, 0, -0.05])                           // small Z fudge
      cylinder(h = bottom_t + 0.1, d = pinhole_size, $fn = 48); // Ø2 mm hole
  }
}

// Option 1: Simple tab handle
module tab_handle() {
  translate([inner_d/2-2, -handle_width/2, 0])
    cube([handle_length, handle_width, handle_thickness]);
}

// Option 2: Rounded tab handle
module rounded_tab_handle() {
  translate([inner_d/2, 0, handle_thickness/2])
    rotate([0, 90, 0])
      hull() {
        cylinder(h = handle_length, d = handle_thickness, $fn = 32);
        translate([0, 0, 0])
          cylinder(h = handle_length, d = handle_width, $fn = 32);
      }
}

// Option 3: Loop handle
module loop_handle() {
  translate([inner_d/2 + handle_length/2, 0, bottom_t/2])
    rotate([90, 0, 0])
      difference() {
        cylinder(h = handle_thickness, d = handle_length, $fn = 64, center = true);
        cylinder(h = handle_thickness + 0.1, d = handle_hole_d, $fn = 32, center = true);
      }
}

// Option 4: Ergonomic curved handle
module curved_handle() {
  translate([inner_d/2, 0, 0]) {
    rotate_extrude(angle = 45, $fn = 64) {
      translate([handle_length/1.5, 0, 0])
        circle(d = handle_thickness, $fn = 16);
    }
  }
}

// Choose your handle style by uncommenting one of these:

// Option 1: Simple tab handle
union() {
  bottom_cap_with_pinhole();
  tab_handle();
}

// Option 2: Rounded tab handle  
// union() {
//   bottom_cap_with_pinhole();
//   rounded_tab_handle();
// }

// Option 3: Loop handle
// union() {
//   bottom_cap_with_pinhole();
//   loop_handle();
// }

// Option 4: Ergonomic curved handle
// union() {
//   bottom_cap_with_pinhole();
//   curved_handle();
// }