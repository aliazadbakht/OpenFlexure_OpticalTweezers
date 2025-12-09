// Single-color parametric adapter WITH visible helical threads (using threads_lib.scad)

use <./threads-scad/threads.scad>; // Using the external thread library for better threads

$fn = 64;                    // general smoothness (raise if you like)
eps = 0.01;

// --- Parameters ---

/* [Laser Diameter] */
laser_diameter = 6; // <-- Change this to fit your laser

/* [Section 1: Screw Thread] */
section1_outer_diameter = 11;   // Major diameter of external thread
section1_inner_diameter = 8;    // Bore
section1_length         = 5;    // Threaded length used to be 4
thread_pitch            = 1;  // Pitch (mm)
thread_tolerance        = 0.10; // Reduces the crest a touch for clearance

/* [NEW: Tapered Transition] */
transition_length       = 0; // Length of the new tapered section

/* [Section 2: Tube] */
section2_outer_diameter = 20;
section2_inner_diameter = 9;
section2_length         = 12;

/* [Section 3: Half Cylinder] */
section3_outer_diameter = 20;
section3_inner_diameter = 12.7;
section3_length         = 6;
half_cut_position       = 10;

/* [NEW: Section 3b: Straight Cylinder] */
section3b_length         = 6;
section3b_outer_diameter = section3_outer_diameter;
section3b_inner_diameter = section3_inner_diameter;


// --- MODIFIED: Sections 4, 5, 6, and 7 now scale based on laser_diameter ---

/* [Section 6: Inner Cylinder] */
section6_inner_diameter = laser_diameter;
section6_outer_diameter = laser_diameter + 6; // Maintains a 3mm wall thickness

/* [Section 5: Cylinder] */
section5_inner_diameter = section6_outer_diameter + 6; // Maintains a 3mm gap from Section 6
section5_outer_diameter = section5_inner_diameter + 8; // Maintains a 4mm wall thickness
section5_length = 40;
/* [Section 5 Holes] */
section5_hole_diameter = 3;
section5_hole_count = 3;
section5_hole_z_position = 5; // Distance from the start of Section 5
section5_hole_rotation_offset = 90; // 90 degrees to align one hole with the half-cylinder cut

/* [Additional Hole] */
new_hole_outer_diameter = 5;
new_hole_inner_diameter = 1;
new_hole_z_offset = 15; // 15mm from the first set of holes

/* [Section 4: Tapered End] */
section4_small_diameter = section3b_outer_diameter;      // Connects to Section 3b
section4_large_diameter = section5_outer_diameter;       // Connects to Section 5
section4_small_inner_diameter = section3b_inner_diameter;  // Tapers from Section 3b's bore
section4_large_inner_diameter = section5_inner_diameter;   // Tapers to Section 5's bore
section4_length         = 10;

/* [Section 7: Connecting Strings] */
section7_string_count = 12;
section7_string_thickness = 1;

// Precomputed Zs
z1 = section1_length;
z_trans = z1 + transition_length; // New Z position after the transition
z2 = z_trans + section2_length;   // Old z2 is now pushed further
z3 = z2 + section3_length;
z3b = z3 + section3b_length;
z4 = z3b + section4_length;


// --- Part ---
module adapter() {
    // Section 1: threaded stub
    difference() {
        ScrewThread(
            outer_diam = section1_outer_diameter,
            height     = section1_length,
            pitch      = thread_pitch,
            tolerance  = thread_tolerance
        );
        translate([0,0,-eps]) cylinder(d = section1_inner_diameter, h = section1_length + 2*eps);
        translate([0,0,-eps])
            cylinder(d1 = section1_outer_diameter + 1, d2 = section1_outer_diameter - 1, h = 0.5 + eps);
    }

        translate([0,0,z1])
            difference() {
        // Outer cone
        cylinder(d1 = section1_outer_diameter, d2 = section2_outer_diameter, h = transition_length);
        // Inner tapered bore
        translate([0,0,-eps]) 
            cylinder(d1 = section1_inner_diameter, d2 = section2_inner_diameter, h = transition_length + 2*eps);
    }
    // ------------------------------------

    // Section 2: tube (Ensure you use the new z_trans variable here)
    translate([0,0,z_trans]) // <-- Use the new Z position
    difference() {
        cylinder(d = section2_outer_diameter, h = section2_length);
        translate([0,0,-eps]) cylinder(d = section2_inner_diameter, h = section2_length + 2*eps);
    }
    // Section 3: half cylinder
    translate([0,0,z2])
    difference() {
        cylinder(d = section3_outer_diameter, h = section3_length);
        translate([0,0,-eps]) cylinder(d = section3_inner_diameter, h = section3_length + 2*eps);
        translate([0, half_cut_position, section3_length / 2])
            cube([section3_outer_diameter + 2, section3_outer_diameter, section3_length + 2*eps], center = true);
    }

    // Section 3b: new cylinder
    translate([0,0,z3])
    difference() {
        cylinder(d = section3b_outer_diameter, h = section3b_length);
        translate([0,0,-eps]) cylinder(d = section3b_inner_diameter, h = section3b_length + 2*eps);
    }


    // Section 4: tapered end
    translate([0,0,z3b])
    difference() {
        cylinder(d1 = section4_small_diameter, d2 = section4_large_diameter, h = section4_length);
        translate([0,0,-eps]) 
            cylinder(d1 = section4_small_inner_diameter, d2 = section4_large_inner_diameter, h = section4_length + 2*eps);
        translate([0,0,section4_length - 0.5])
            cylinder(d1 = section4_large_inner_diameter, d2 = section4_large_inner_diameter + 2, h = 0.5 + eps);
    }

    // Section 5: new cylinder with holes
    translate([0,0,z4])
    difference() {
        cylinder(d = section5_outer_diameter, h = section5_length);
        translate([0,0,-eps]) cylinder(d = section5_inner_diameter, h = section5_length + 2*eps);

        // Original 3 holes
        translate([0,0,section5_hole_z_position])
            for(i=[0:section5_hole_count-1]){
                rotate([0,0, section5_hole_rotation_offset + i * 360 / section5_hole_count])
                    translate([section5_inner_diameter / 2 - eps, 0, 0])
                        rotate([0,90,0])
                            cylinder(d = section5_hole_diameter, h = (section5_outer_diameter - section5_inner_diameter) / 2 + 2*eps);
            }
        
        // New 5mm hole in outer cylinder
        translate([0,0,section5_hole_z_position + new_hole_z_offset])
            rotate([0,0,section5_hole_rotation_offset])
                translate([section5_inner_diameter / 2 - eps, 0, 0])
                    rotate([0,90,0])
                        cylinder(d=new_hole_outer_diameter, h=(section5_outer_diameter - section5_inner_diameter) / 2 + 2*eps);
    }

    // Section 6: Inner cylinder with new hole
    translate([0,0,z4])
    difference() {
        cylinder(d = section6_outer_diameter, h = section5_length);
        translate([0,0,-eps]) cylinder(d = section6_inner_diameter, h = section5_length + 2*eps);
        
        // New 1mm through-hole in inner cylinder
        translate([0,0,section5_hole_z_position + new_hole_z_offset])
            rotate([0,0,section5_hole_rotation_offset])
                 rotate([0,90,0])
                    cylinder(d=new_hole_inner_diameter, h=section6_outer_diameter * 2, center=true);
    }

    // Section 7: Connecting Strings
    translate([0,0,z4 + section5_length-0.5])
    for (i = [0 : section7_string_count - 1]) {
        rotate([0, 0, i * 360 / section7_string_count])
        translate([section6_outer_diameter/2, 0, 0])
            cube([(section5_inner_diameter - section6_outer_diameter), section7_string_thickness, section7_string_thickness], center = true);
    }
}

// --- Render ---
mirror([0,0,1]){
    adapter();
}
//ScrewThread(outer_diam = section1_outer_diameter, height     = section1_length,pitch      = thread_pitch,tolerance  = thread_tolerance);
total_height = z4 + section5_length;

translate([40,0,-total_height])
difference() {
cylinder(d = section3_outer_diameter, h = section3_length);
translate([0,0,-eps]) cylinder(d = section3_inner_diameter, h = section3_length + 2*eps);
translate([0, half_cut_position, section3_length / 2])
    cube([section3_outer_diameter + 2, section3_outer_diameter, section3_length + 2*eps], center = true);
}