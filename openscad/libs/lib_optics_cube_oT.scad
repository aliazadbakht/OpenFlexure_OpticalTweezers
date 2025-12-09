// lib_optics_cube_oT.scad - RMS optics module with cube_oT
use <./utilities.scad>
use <./microscope_parameters.scad>
use <./libdict.scad>
use <./lib_cube_oT.scad>
use <./rms_calculations.scad>
use <./rms_thread.scad>
use <./cameras/camera.scad>
use <./z_axis.scad>

// Import only the basic modules you need from lib_optics
use <./lib_optics.scad>

// ===== RMS OPTICS MODULE WITH CUBE oT =====
module optics_module_rms_cube_oT(params, optics_config, include_wedge=true){
    assert(key_lookup("optics_type", optics_config)=="RMS",
        "Cannot create an RMS optics module for a non-RMS configuration.");
    beamsplitter = key_lookup("beamsplitter", optics_config);
    pedestal_h = 2;
    wedge_top = 27;
    
    rms_optics_mount_z = tube_lens_face_z(params, optics_config) - pedestal_h;
    rms_optics_mount_base_r = rms_thread_nominal_d()/2+1;
    rms_optics_mount_h = objective_shoulder_z(params, optics_config)-rms_optics_mount_z;
    camera_mount_top_z = rms_camera_mount_top_z(params, optics_config);
    
    difference(){
        union(){
            difference(){
                // Body with cube_oT external shape
                optics_module_body_cube_oT(
                    params, optics_config,
                    body_r=rms_optics_mount_base_r,
                    bottom_r=10.5,
                    body_top=rms_optics_mount_z,
                    rms_mount_h=rms_optics_mount_h,
                    wedge_top=wedge_top,
                    include_wedge=include_wedge
                );
                // RMS thread cutout
                translate_z(rms_optics_mount_z){
                    rms_thread_and_cutout_for_tube_lens(rms_optics_mount_h);
                }
            }
            
            // Tube lens gripper
            translate_z(rms_optics_mount_z){
                tube_lens_gripper(optics_config, pedestal_h=pedestal_h);
            }
        }
        
        // Optical path with cube_oT
        if(beamsplitter){
            optical_path_cube_oT(params, optics_config, rms_optics_mount_z, camera_mount_top_z);
            
            // --- FIX: Open horizontal light path through the outer shell ---
            // This clears the path for the illuminator to reach the cube's horizontal hole
            rotate([0, 0, 90])
            cylinder(d=9, h=60, center=true, $fn=64); 
        }
        else{
            optical_path(optics_config, rms_optics_mount_z, camera_mount_top_z);
        }
    }
}

// ===== BODY MODULE WITH CUBE oT =====
module optics_module_body_cube_oT(params, optics_config, body_r, body_top, rms_mount_h, wedge_top, bottom_r, include_wedge){
    beamsplitter = key_lookup("beamsplitter", optics_config);
    difference(){
        optics_module_body_outer_cube_oT(params, optics_config, body_r, body_top, rms_mount_h, wedge_top, bottom_r, include_wedge);
        if (include_wedge){
            translate_z(-1){
                objective_fitting_cutout(params);
            }
        }
        
        if(beamsplitter){
            optics_module_cube_oT_cutout(params, optics_config);
        }
    }
}

// ===== OUTER BODY SHAPE WITH CUBE oT =====
module optics_module_body_outer_cube_oT(params, optics_config, body_r, body_top, rms_mount_h, wedge_top, bottom_r, include_wedge){
    beamsplitter = key_lookup("beamsplitter", optics_config);
    camera_rotation = key_lookup("camera_rotation", optics_config);
    camera_mount_top_z = rms_camera_mount_top_z(params, optics_config);
    
    module top_of_camera_mount_in_place(){
        rotate(camera_rotation){
            translate_z(camera_mount_top_z){
                camera_mount_top_slice(optics_config);
            }
        }
    }
    
    module bottom_of_body_and_wedge(){
        translate_z(optics_wedge_bottom()){
            cylinder(r=bottom_r, h=tiny());
        }
        if (include_wedge){
            translate_z(optics_wedge_bottom()){
                objective_fitting_wedge(h=tiny());
            }
        }
    }
    
    module top_of_body_and_wedge(){
        translate_z(body_top){
            cylinder(r=body_r, h=tiny());
        }
        if (include_wedge){
            translate_z(wedge_top){
                objective_fitting_wedge(h=tiny());
            }
        }
    }
    
    union(){
        if(beamsplitter){
            sequential_hull(){
                top_of_camera_mount_in_place();
                union(){
                    bottom_of_body_and_wedge();
                    cube_oT_casing_bottom(params, optics_config);
                }
                union(){
                    top_of_body_and_wedge();
                    extra_optics_body_for_cube_oT(params, optics_config);
                }
            }
        }
        else{
            sequential_hull(){
                top_of_camera_mount_in_place();
                bottom_of_body_and_wedge();
                top_of_body_and_wedge();
            }
        }
        
        // Camera mount
        rotate(camera_rotation){
            translate_z(camera_mount_top_z){
                camera_mount(optics_config);
            }
        }
        
        // RMS housing
        translate_z(body_top){
            cylinder(r=body_r, h=rms_mount_h);
        }
    }
}

// Add this where you want the screw hole
module screw_hole(shaft_d=4, head_d=8, head_h=3, length=20) {
    translate([3, 0, -28])
    union() {
        // Shaft hole
        cylinder(d=shaft_d, h=length, $fn=30);
        // Countersink for screw head
        cylinder(d=head_d, h=head_h, $fn=30);
    }
}




module _custom_screw_cutout() {
    $fn = 60; 
    // Screw Head: 4mm wide, ~4mm deep
    translate([0, 0, -2]) 
        cylinder(d=4, h=4.01); 
        
    // Screw Shaft: 2mm wide
    translate([0, 0, -20]) 
        cylinder(d=2, h=20);
}

// The new Main Module that includes the holes
module optics_module_rms_cube_oT_custom(params, optics_config) {
    difference() {
        // 1. Generate the original object (This works because we are in the same file!)
        optics_module_rms_cube_oT(params, optics_config);

        // 2. Subtract the first hole
        translate([5, -6, -30.5]) 
            rotate([180, 0, 0])
                _custom_screw_cutout();

        // 3. Subtract the second hole
        translate([5, 16, -5]) 
            rotate([0, 90, 90])
                _custom_screw_cutout();
    }
}