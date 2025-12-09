# OpenFlexure Optical Tweezers

An extension for the [OpenFlexure Microscope](https://openflexure.org/) that adds optical tweezers functionality. The OpenFlexure Project provides open-source, 3D-printed microscopes with precise mechanical positioning - this project extends that capability with laser-based optical trapping.

## 🎮 Try the Interactive Simulation

**[Launch Web Simulation →](https://aliazadbakht.github.io/OpenFlexure_OpticalTweezers/)**

Experience optical tweezers physics directly in your browser! Click and drag particles, watch them escape the trap, and observe real-time Brownian motion. No installation required - works on any device.

![Optical Tweezers Simulation](https://img.shields.io/badge/Try%20It-Interactive%20Demo-blue?style=for-the-badge)

## What's Included

### 📐 CAD Files
- **`ipt/`** - Autodesk Inventor (.ipt) and Assembly (.iam) files for modification in Fusion 360 or Inventor
  - Coupler (`cuppler_ot.ipt`)
  - Laser Holder Assembly (`Laser Holder 3.0 .iam`)
  - Objective Holder (`Objective Holder.ipt`)
  - Cube parts (`Cube .ipt`, `Part10.ipt`)
  - Main assembly (`OpenFlexure Optical Tweezers.iam`)

### 🖨️ Ready-to-Print Files
- **`stl/`** - STL and 3MF files ready for 3D printing
  - Complete assembly: `OpenFlexure Optical Tweezers.3mf`
  - Coupler: `Cuppler.stl`
  - Cube: `Cube.stl`
  - Laser holders: `Laser Holder 12 mm laser.stl`, `laser Holder 6 mm laser .stl`
  - Lens lid: `Lens Lid.stl`
  - RMS optics module: `RMS optics module OT.stl`

### 🔧 OpenSCAD Files
- **`openscad/`** - Parametric designs for customization
  - `alignment_cap.scad` and `alignment_tool.scad` - Helpers for aligning optics and laser
  - `cuppler_ot.scad` - Coupler between the cube and laser holder
  - `laser_holder_OT.scad` - Laser mount with adjustable diameter
  - `cube_OT.scad` - Optical cube housing
  - `rms_optics_module_ot.scad` - RMS-threaded optics adapter
  - Supporting library files in `openscad/libs/`

### 💻 Simulation Software
- **`Optical Tweezers Simulation/`** - Interactive physics simulation
  - **[Web Version](https://aliazadbakht.github.io/OpenFlexure_OpticalTweezers/)** - Run directly in your browser (no installation!)
  - Python desktop version with real-time visualization
  - Click-and-drag interaction to test trap strength
  - Real-time force visualization and Brownian motion
  - Educational tool for understanding optical trap dynamics

## Building the Hardware

### Prerequisites
1. Access to a 3D printer
2. OpenFlexure Microscope base (see [OpenFlexure documentation](https://openflexure.org/projects/microscope/))
3. Laser diode (typically 635nm red laser, adjustable diameter in SCAD files)
4. RMS-threaded objective lens

### Using the OpenSCAD Files

The OpenSCAD files require dependencies from the main OpenFlexure project:

1. Clone the OpenFlexure Microscope repository:
   ```bash
   git clone https://gitlab.com/openflexure/openflexure-microscope.git
   ```

2. Install the threads library **inside this project's OpenSCAD folder**:
  ```bash
  cd OpenFlexureOT
  git clone https://github.com/rcolyer/threads-scad.git openscad/threads-scad
  ```

3. Keep this project's `openscad/` folder alongside the OpenFlexure `openscad/` files (so shared includes resolve):
  ```
  your-workspace/
  ├── openflexure-microscope/
  │   └── openscad/               (OpenFlexure base files)
  └── OpenFlexureOT/
     └── openscad/               (This project's files + threads-scad/)
        ├── threads-scad/
        ├── libs/
        └── *.scad
  ```

4. Open the SCAD files and customize parameters:
   - `laser_diameter` - Match your laser diode size (default: 6mm)
   - Thread dimensions for your specific hardware
   - Mounting geometry

5. Render and export STL files from OpenSCAD

### Required Libraries for OpenSCAD
- [OpenFlexure OpenSCAD files](https://gitlab.com/openflexure/openflexure-microscope/-/tree/master/openscad)
- [threads-scad library](https://github.com/rcolyer/threads-scad) by rcolyer

## Running the Simulation

### Web Version (Recommended)
Simply visit **[https://aliazadbakht.github.io/OpenFlexure_OpticalTweezers/](https://aliazadbakht.github.io/OpenFlexure_OpticalTweezers/)**
- No installation required
- Works on any device (desktop, tablet, mobile)
- First load takes 10-30 seconds (downloads Python runtime)
- Fully interactive with click-and-drag

### Local Python Version
For faster performance and offline use:

```bash
cd "Optical Tweezers Simulation"
pip install -r requirements.txt
python opticaltweezers_simulation.py  # Desktop version with mouse interaction
```

The simulation demonstrates optical trap physics, including:
- **Brownian motion** - Random thermal fluctuations
- **Trap escape dynamics** - Drag particles beyond the escape radius
- **Force visualization** - See trap force magnitude and direction in real-time
- **Boltzmann statistics** - Compare experimental data with theoretical predictions

## Acknowledgments

This project is supported by **[Wavefront Principle B.V.](https://wfront.nl/)**, a pre-incubator dedicated to transforming innovative ideas into real-world devices.

Special thanks to **[Mojtaba Nosratloo](https://www.linkedin.com/in/mojtaba-nosratlo-b62404a9/)** for his significant contributions to the design and development of this project.

## License

MIT License