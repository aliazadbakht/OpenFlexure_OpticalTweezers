use <./libs/microscope_parameters.scad>
use <./libs/lib_optics_cube_oT.scad>
use <./libs/optics_configurations.scad>



OPTICS = "rms_infinity_f50d13";
BEAMSPLITTER = true;
CAMERA = "picamera_2";
PARFOCAL_DISTANCE = 45;

// Setup parameters
params = default_params();
optics_config = rms_infinity_f50d13_config(
    camera_type=CAMERA,
    beamsplitter=BEAMSPLITTER,
    parfocal_distance=PARFOCAL_DISTANCE
);

// --- CALL THE NEW CUSTOM MODULE ---
// Since we added this to 'lib_optics_cube_oT.scad', it will now work!
optics_module_rms_cube_oT_custom(params, optics_config);