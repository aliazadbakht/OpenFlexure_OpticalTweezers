use <./libs/utilities.scad>
use <./libs/lib_fl_cube.scad>
use <./libs/static_dovetail.scad>
use <./threads-scad/threads.scad>;

$fn=32;

/**
* Creates a 3D trapezoid bar shape to fit into the cube_OT
*/
module trapezoid_bar(large_side=4, small_side=2, trapezoid_height=1, length=20) {
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

/**
* The width of illuminator holder
*/
function illuminator_width() = 18;

/**
* Radius of the star LED used for reflection illumination.
*/
function ledstar_r() = 19/2;

/**
* Clearance radius to give the extra space needed to fit the screw head next to the LEDstar
*/
function ledstar_clearance_r() = ledstar_r() + 2.8;

/**
* Thickness of the reflection illuminator slip plate
*/
function slip_plate_thickness() = 2;

/**
* The z-position of the mounted filter cube
*/
function filter_cube_z() = ledstar_clearance_r()-fl_cube_w()/2;

/**
* Height of the block the filter cube mounts to. Total structure is taller by
* the thickness of the slip plate.
*/
function fl_cube_mount_h() = fl_cube_w() + filter_cube_z() + 2;

module fl_cube_mount(beam_d=6){
    beam_z = filter_cube_z() + fl_cube_w()/2;
    roc = 0.6;
    w = illuminator_width();

    difference(){
        // --- ADDITIVE GEOMETRY ---
        union(){
            // The main body of the mount - extended to cover the threaded area
            hull(){
                // Cube at far end (y=10), extended down to match slip plate height
                translate([-w/2, 10, -slip_plate_thickness()]){
                    cube([w, 0.1, fl_cube_mount_h() + slip_plate_thickness()]);
                }
                // Cube at near end (y=0), stays at z=0 to preserve slope
                translate([-w/2, 0, 0]){
                    cube([w, 0.1, fl_cube_mount_h()]);
                }
                reflect_x(){
                    // Cylinders at y=2, extended down
                    translate([w/2-roc, 3, -slip_plate_thickness()]){
                        cylinder(r=roc, h=fl_cube_mount_h() + slip_plate_thickness(), $fn=16);
                    }
                }
            }
        }

        // --- SUBTRACTIVE GEOMETRY ---
        translate_z(beam_z){
            union(){
                // SUBTRACT the beam hole
                printable_horizontal_hole(h=999, r=beam_d/2, $fn=16, extra_height=0, center=true);

                // SUBTRACT the threaded hole
                translate([0, 11, 0]){
                    rotate([90, 0, 0]){
                        ScrewThread(
                            outer_diam = 11 + 0.1,
                            height     = 14,
                            pitch      = 1
                        );
                    }
                }
            }
        }
    }
}

/**
* The mounting structure to hold the for the slip plate onto the optics module
* This forms part of the `illuminator_holder()`
*/
module reflection_illumintor_mount(){
    depth = 4;
    screw_height = filter_cube_z()+slip_plate_thickness()+2;
    height = fl_cube_mount_h()+slip_plate_thickness();

    w_bottom = fl_cube_w()+11;
    w_middle = fl_cube_w()+10;
    w_top = fl_cube_w()+1.5;
    w_cut = fl_cube_w()+1;
    difference(){
        hull(){
            translate_x(-w_bottom/2){
                cube([w_bottom, depth, 4]);
            }
            translate_x(-w_middle/2){
                cube([w_middle, depth, screw_height]);
            }
            translate([-w_top/2, 0 , height-tiny()]){
                cube([w_top, depth, tiny()]);
            }
        }
        translate_z(100+screw_height){
            cube([w_cut, 3*depth, 200], center=true);
        }

        reflect_x(){
            //mounting hole to optics module
            translate([(fl_cube_w()/2+3),-tiny(),screw_height]){
                rotate_x(-90){
                    cylinder(d = 2.6, h= 6, $fn=10);
                }
            }
        }
    }
}

/**
* The slip plate including the structure to mount it to the optics module
* This forms part of the `illuminator_holder()`
*/
module mounted_illumintor_slip_plate(){
    difference(){
        union(){
            reflection_illumintor_mount();
        }
        //chamfer the front
        hull(){
            translate_z(-tiny()){
                cube([999,4,tiny()], center=true);
            }
            translate([0, -tiny(), 2]){
                cube([999,tiny(),tiny()], center=true);
            }
        }
    }
}

/**
* Geometry of illuminator holder
*/
module illuminator_holder(){
    difference(){
        union(){
            mounted_illumintor_slip_plate();
            translate_z(slip_plate_thickness()){
                fl_cube_mount();
            }
        }
        translate([-9,1,21]){
            mirror([0,1,0]){
                rotate([0, 90, 0]) {
                    // Scaled up to add print tolerance/clearance (makes slot larger for easier fit)
                    // Using 1.04 = 4% larger to match the 4% smaller male part (0.96 scale)
                    scale([1.04, 1., 1.0]) {
                        trapezoid_bar();
                    }
                }
            }
        }
        // Cut 1 mm from top
        translate_z(fl_cube_mount_h() + slip_plate_thickness() - 0.5){
            cube([999, 999, 1], center=true);
        }
    }
}

illuminator_holder();
