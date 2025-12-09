// --- Parameters ---
outer_size = 18;       // Outer dimensions (mm)
wall_thickness = 1;    // Wall thickness (mm)
wedge_leg = 14.5;      // Length of the triangle legs
wedge_width = 16;      // Width of the wedge
connector_size = 1.5;  // Size of the tiny attachment piece
hole_diameter = 8.5;   // Diameter of the round holes

// New Plate Parameters
plate_dist_from_corner = 9; 
plate_thickness = 1.1;      
plate_length = 9;           // Extracted length for calculation
rod_diameter = 1.5;         // Controls the size of the rod

// Slot Parameters
slot_width = 10;       // X direction
slot_height = 1.1;     // Z direction (thickness)

// Small side hole parameters (on -X and -Z faces)
side_hole_diameter = 3;      // Diameter of small holes
side_hole_offset   = 3;    // Distance from top and right edges (mm)

// Calculate inner size
inner_size = outer_size - 2 * wall_thickness; // 15mm

// --- Main Cube Body as a module ---
module cube_body() {

    difference() {

        // 1. The Positive Object (Frame + Wedge + Connector + NEW PLATE + TRAPEZOID BAR)
        union() {
            // The Hollow Frame
            difference() {
                cube([outer_size-1, outer_size-2, outer_size], center = true);
                cube([inner_size, inner_size, inner_size], center = true);
                cube([inner_size, outer_size + 2, inner_size], center = true);
            }

            // The 45-Degree Wedge
            translate([
                -inner_size/2 + 0.5, 
                0, 
                -inner_size/2 + 0.5
            ])
            rotate([90, 0, 0])
            linear_extrude(height = wedge_width, center = true)
            polygon(points=[
                [0, 0],            
                [wedge_leg, 0],    
                [0, wedge_leg]     
            ]);

            // --- NEW: The Parallel 45-Degree Plate & Connector ---
            // gripper
            rotate([0, 225, 0]) {
                
                // 1. The Floating Plate (Original)
                translate([4, 0, -1.2]) 
                cube([plate_length, wedge_width, plate_thickness], center=true); 

                // The Tiny Rod Below
                translate([0, 0, -1]) 
                rotate([90, 0, 0]) // Rotates cylinder to lay flat
                rotate([0,0,0])   // Runs along the Y axis (width)
                cylinder(d=rod_diameter, h=wedge_width, center=true, $fn=30);

                // 2. The Tiny Connector 
                rotate([0, 45, 0]){
                    translate([wedge_width/2-1.5, 0, wedge_width/2-2])
                    cube([1.5, wedge_width, 3], center=true);
                }
            }

            // The Tiny Connector (Original corner piece)
            translate([
                -inner_size/2 + connector_size/2, 
                0, 
                -inner_size/2 + connector_size/2
            ])
            cube([connector_size, wedge_width, connector_size], center=true);
            
            // --- NEW: Positive Trapezoid Bar on +X wall ---
            // This protrudes outward and will fit into the illuminator holder slot in cuppler_ot.scad
            translate([outer_size/2 + 0.7, -outer_size/2+1, -6.5]) {
                rotate([0, 90, 90]) {
                    scale([1.04, 1.3, 1.0]) {
                        trapezoid_bar();
                    }
                }
            }
        }

        // 2. The Negative Shapes (Holes)
        
        // Hole A: Vertical (Z-axis) cylinder
        cylinder(d = hole_diameter, h = outer_size + 2, center = true, $fn=100);

        // Hole B: Horizontal (+X wall) cylinder
        translate([outer_size/2, 0, 0]) 
        rotate([0, 90, 0])              
        cylinder(d = hole_diameter, h = 5, center = true, $fn=100); 

        // Hole C: Rectangular Slot in the Wedge
        translate([
            -0.8, 
            0, 
            -inner_size/2 + 0 + 2 
        ])
        cube([slot_width, outer_size + 5, slot_height], center = true);

        // --- Small 3 mm circular hole on -X side ---
        translate([
            -outer_size/2,                               // On the -X wall
            (outer_size - 2)/2 - side_hole_offset,       // 2.5 mm from right edge (Y+)
            outer_size/2 - side_hole_offset              // 2.5 mm from top edge (Z+)
        ])
        rotate([0, 90, 0])                               // Hole axis along X
        cylinder(d = side_hole_diameter, h = 2, center = true, $fn = 60);

        // --- Small 3 mm circular hole on -Z side ---
        translate([
            outer_size/2 - side_hole_offset -0.5,             // 2.5 mm from right edge (X+)
            (outer_size - 2)/2 - side_hole_offset ,       // 2.5 mm from top edge (Y+)
            -outer_size/2                                // On the -Z wall
        ])
        cylinder(d = side_hole_diameter, h = 2, center = true, $fn = 60);
    }
}

// --- Trapezoid Bar Module Definition ---
module trapezoid_bar(large_side=4, small_side=2, trapezoid_height=1, length=16) {
    points = [
        [-large_side / 2, 0],
        [large_side / 2, 0],
        [small_side / 2, trapezoid_height],
        [-small_side / 2, trapezoid_height]
    ];
    
    linear_extrude(height = length) {
        polygon(points);
    }
}

// Default render for standalone viewing
rotate([90,0,0])
    cube_body();
