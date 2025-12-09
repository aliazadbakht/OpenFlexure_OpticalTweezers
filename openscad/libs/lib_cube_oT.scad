// lib_cube_oT.scad - Custom cube implementation for openUC2/oT system
use <./utilities.scad>
use <./libdict.scad>
use <./lighttrap.scad>
use <./rms_calculations.scad>

// ===== CUBE oT PARAMETERS =====
function cube_oT_w() = 17; // Cube width (x and y dimensions)
function cube_oT_h() = 18; // Cube height (z dimension)
function cube_oT_roc() = 0.6;
function cube_oT_bottom(params, optics_config) = rms_camera_sensor_z(params, optics_config) + 8;
function cube_oT_top(params, optics_config) = cube_oT_bottom(params, optics_config) + cube_oT_h() + 2.7;

// ===== CUBE oT CUTOUT =====
// ===== CUBE oT CUTOUT - PURE RECTANGULAR BOX =====
module cube_oT_cutout(params, optics_config, taper=true){
    cube_cutout_w = cube_oT_w(); // 17mm - tight fit
    cube_cutout_h = cube_oT_h() + 1; // 19mm
    cube_bottom = cube_oT_bottom(params, optics_config);
    
    // Pure rectangular box cutout
    translate([-cube_cutout_w/2, -cube_oT_w()/2, cube_bottom]){
        cube([cube_cutout_w, 999, cube_cutout_h]);
    }
}

// ===== CUBE oT CASING (external body) =====
module cube_oT_casing(params, optics_config){
    minkowski(){
        difference(){
            cube_oT_cutout(params, optics_config);
            translate([-999, cube_oT_w()/2, -999]){
                cube(999*2);
            }
        }
        cylinder(r=1.6, h=0.5);
    }
}

// ===== TWO SCREW HOLES (left and right) =====
module cube_oT_screw_holes(params, optics_config, d, h){
    // Two screw holes positioned on left and right sides
    reflect_x(){
        translate([cube_oT_w()/2 + 3 , 0, cube_oT_bottom(params, optics_config) + cube_oT_h()+1 - 2.8]){
            rotate_x(90){
                trylinder_selftap(d, h);
            }
        }
    }
}

// ===== OPTICAL PATH WITH CUBE oT =====
module optical_path_cube_oT(params, optics_config, lens_z, camera_mount_top_z){
    bs_rotation = key_lookup("beamsplitter_rotation", optics_config);
    tube_lens_r = key_lookup("tube_lens_r", optics_config);
    aperture_r = tube_lens_r - 1.5;
    rotation = 180 + bs_rotation;
    
    rotate(rotation){
        union(){
            // Path from camera to cube bottom
            translate_z(camera_mount_top_z-tiny()){
                camera_mount_to_cube = cube_oT_bottom(params, optics_config) - camera_mount_top_z;
                ridge = (camera_mount_to_cube > 3) ? 1.5 : camera_mount_to_cube/2;
                lighttrap_sqylinder(
                    r1=5, f1=0,                          // Bottom: circle r=5mm
                    r2=0, f2=cube_oT_w()-4,              // Top: square 17-4=13mm
                    h=camera_mount_to_cube+2*tiny(),
                    ridge=ridge
                );
            }
            
            // Cube cutout
            cube_oT_cutout(params, optics_config);
            
            // Path from cube top to lens
            translate_z(cube_oT_top(params, optics_config)-tiny()){
                lighttrap_sqylinder(
                    r1=1.5, f1=cube_oT_w()-4-3,          // Bottom: square with small circle
                    r2=aperture_r, f2=0,                  // Top: circle
                    h=lens_z-cube_oT_top(params, optics_config)+4*tiny()
                );
            }
            
            // Lens aperture
            translate_z(lens_z){
                cylinder(r=aperture_r, h=99);
            }
        }
    }
}

// ===== EXTRA BODY FOR CUBE oT =====
module extra_optics_body_for_cube_oT(params, optics_config){
    bs_rotation = key_lookup("beamsplitter_rotation", optics_config);
    rotate(bs_rotation){
        // Just use the casing without hulling to avoid small appendices below screw holes
        cube_oT_casing(params, optics_config);
        cube_oT_screw_holes(params, optics_config, d=4, h=8);
    }
}

module cube_oT_casing_bottom(params, optics_config){
    bottom = cube_oT_bottom(params, optics_config);
    translate_z(bottom){
        thick_section(){
            translate_z(-bottom){
                extra_optics_body_for_cube_oT(params, optics_config);
            }
        }
    }
}

// ===== BEAMSPLITTER CUTOUT (for mounting holes and front opening) =====
module optics_module_cube_oT_cutout(params, optics_config){
    bs_rotation = key_lookup("beamsplitter_rotation", optics_config);
    cube_dim = [1, 1, 1] * cube_oT_w();
    cube_centre_z = cube_oT_bottom(params, optics_config) + cube_oT_h()/2;
    
    rotate(bs_rotation){
        // Two screw holes for mounting (2.5mm diameter, 6mm deep)
        translate_y(-2.5){
            cube_oT_screw_holes(params, optics_config, d=2.5, h=6);
        }
        
        // Front opening for cube access
        hull(){
            translate([0, -cube_oT_w(), cube_centre_z+3.5]){
                cube(cube_dim + [15, 0, 7], center=true);
            }
            translate([0, -cube_oT_w()-6, cube_centre_z+9]){
                cube(cube_dim + [20, 0, 6], center=true);
            }
        }
    }
}




///////
