# OpenFlexure Optical Tweezers

An extension for the [OpenFlexure Microscope](https://openflexure.org/) that adds optical tweezers functionality. The OpenFlexure Project provides open-source, 3D-printed microscopes with precise mechanical positioning — this project extends that capability with laser-based optical trapping.

## Demo Video

[![Watch on YouTube](https://img.youtube.com/vi/GGlHxX-9Ro8/0.jpg)](https://youtu.be/GGlHxX-9Ro8)

Full assembly walkthrough covering the basics, required parts, and what you need to get started. Click the thumbnail to watch on YouTube.

## Try the Interactive Simulation

**[Launch Web Simulation →](https://aliazadbakht.github.io/OpenFlexure_OpticalTweezers/)**

Experience optical tweezers physics directly in your browser! Click and drag particles, watch them escape the trap, and observe real-time Brownian motion. No installation required — works on any device.

---

## Table of Contents

- [Project Structure](#project-structure)
- [What's Included](#whats-included)
- [Installation](#installation)
- [Usage Guide](#usage-guide)
  - [Optical Tweezers Simulation](#1-optical-tweezers-simulation)
  - [Microrheology Simulation](#2-microrheology-simulation)
- [Building the Hardware](#building-the-hardware)
- [Bill of Materials](#bill-of-materials)
- [Acknowledgments](#acknowledgments)
- [License](#license)

---

## Project Structure

```
OpenFlexureOT/
├── README.md                          # This file
├── BOM.md                             # Bill of materials
├── LICENSE                            # CERN-OHL-S v2
├── index.html                         # GitHub Pages landing page
├── requirements.txt                   # Python dependencies (simulation)
│
├── Optical Tweezers Simulation/       # Interactive physics simulation
│   ├── opticaltweezers_simulation.py  # Desktop Python version
│   ├── index.html                     # Web version (PyScript, runs in browser)
│   ├── requirements.txt               # Python dependencies
│   ├── README.md                      # Simulation-specific documentation
│   └── DEPLOYMENT.md                  # GitHub Pages deployment guide
│
├── Microrheology Simulation/          # Browser-based microrheology demo
│   ├── Microrheology simulation.html
│   └── deploy/
│
├── openscad/                          # Parametric CAD files for customization
│   ├── cube_OT.scad
│   ├── laser_holder_OT.scad
│   ├── rms_optics_module_ot.scad
│   ├── cuppler_ot.scad
│   ├── alignment_cap.scad
│   ├── alignment_tool.scad
│   └── libs/
│
├── ipt/                               # Autodesk Inventor files (.ipt, .iam)
│
└── stl/                               # Ready-to-print STL and 3MF files
```

---

## What's Included

### CAD Files
- **`ipt/`** — Autodesk Inventor source files (.ipt/.iam) for modification in Fusion 360 or Inventor
- **`openscad/`** — Parametric OpenSCAD designs for customization (laser diameter, thread sizing, etc.)
- **`stl/`** — Ready-to-print STL and 3MF files for 3D printing

### Simulation Software
- **Optical Tweezers Simulation** — Interactive physics simulation (web + desktop)
- **Microrheology Simulation** — Browser-based microrheology demo

### Tractor-Beam Canvas Demo (Embeddable)
A lightweight, pure HTML/JS optical tweezers animation that runs in any browser. You can copy the canvas section and script from the main `index.html` and embed it into your own website — no dependencies required.

---

## Installation

### Prerequisites

- **Python 3.11+** (required for simulation software)
- **Git** (to clone the repository)

### Step 1: Clone the Repository

```bash
git clone https://github.com/aliazadbakht/OpenFlexureOT.git
cd OpenFlexureOT
```

### Step 2: Create a Virtual Environment (Recommended)

```bash
python -m venv venv

# On macOS/Linux:
source venv/bin/activate

# On Windows:
venv\Scripts\activate
```

### Step 3: Install Dependencies

```bash
pip install -r requirements.txt
```

---

## Usage Guide

### 1. Optical Tweezers Simulation

An interactive simulation of optical trap physics including Brownian motion, trap escape dynamics, and force visualization.

#### Web Version (No Installation)

Visit **[https://aliazadbakht.github.io/OpenFlexure_OpticalTweezers/](https://aliazadbakht.github.io/OpenFlexure_OpticalTweezers/)**

- Works on any device (desktop, tablet, mobile)
- First load takes 10–30 seconds (downloads Python runtime)
- Fully interactive with click-and-drag

#### Desktop Version

```bash
cd "Optical Tweezers Simulation"
pip install -r requirements.txt
python opticaltweezers_simulation.py
```

**Controls:**
- **Click and hold** on the particle to grab it
- **Drag** the particle around to move it
- **Release** inside the trap zone — the particle snaps back
- **Release** outside the escape radius — the particle escapes

**What you'll see:**
- Real-time Brownian motion of a trapped particle
- Green arrows showing trap force (in piconewtons)
- Position histogram with Boltzmann distribution overlay
- Time-series plot of particle position

---

### 2. Microrheology Simulation

Open `Microrheology Simulation/Microrheology simulation.html` in any web browser. No installation required.

---

## Building the Hardware

### Prerequisites

1. A 3D printer (PLA or PETG recommended)
2. OpenFlexure Microscope base — see [OpenFlexure documentation](https://openflexure.org/projects/microscope/)
3. Laser diode (typically 635 nm red, ~1 mW)
4. High-NA objective lens (NA >= 0.8, RMS threaded)
5. Optical components listed in [BOM.md](BOM.md)

### Assembly Steps

1. **Print the parts** — use the STL files from `stl/` or the combined `OpenFlexure Optical Tweezers.3mf`
2. **Install brass heat-set inserts** into the laser holder (3x M3)
3. **Mount the dichroic mirror** inside the optical cube
4. **Install the lenses** (f=17–20mm doublet and f=50mm doublet)
5. **Mount the laser** into the laser holder with adjustment screws
6. **Attach the coupler** between the cube and laser holder
7. **Install the objective** into the RMS optics module
8. **Mount onto the OpenFlexure Microscope** base

Watch the [assembly video](https://youtu.be/GGlHxX-9Ro8) for a detailed walkthrough.

### Customizing with OpenSCAD

The OpenSCAD files require dependencies from the main OpenFlexure project:

```bash
# 1. Clone the OpenFlexure Microscope repository
git clone https://gitlab.com/openflexure/openflexure-microscope.git

# 2. Install the threads library inside this project's OpenSCAD folder
cd OpenFlexureOT
git clone https://github.com/rcolyer/threads-scad.git openscad/threads-scad
```

Keep the folder structure like this:

```
your-workspace/
├── openflexure-microscope/
│   └── openscad/               # OpenFlexure base files
└── OpenFlexureOT/
    └── openscad/               # This project's files
        ├── threads-scad/
        ├── libs/
        └── *.scad
```

Customize parameters in the SCAD files:
- `laser_diameter` — match your laser diode size (default: 6 mm)
- Thread dimensions for your specific hardware
- Mounting geometry

Render and export STL files from OpenSCAD.

---

## Bill of Materials

See [BOM.md](BOM.md) for the full list of components including optical parts, fasteners, and electronics.

---

## Acknowledgments

This project is supported by **[Wavefront Principle B.V.](https://wfront.nl/)**, a pre-incubator dedicated to transforming innovative ideas into real-world devices.

It is also supported by **[Precisometer B.V.](https://www.precisometer.com)**, a company specialized in microscopy.

Special thanks to **[Mojtaba Nosratloo](https://www.linkedin.com/in/mojtaba-nosratlo-b62404a9/)** for his significant contributions to the design and development of this project.

---

## License

This project is licensed under the CERN Open Hardware Licence Version 2 — Strongly Reciprocal (CERN-OHL-S v2). See the [LICENSE](LICENSE) file for details.

This license is used because this project incorporates and builds upon OpenFlexure designs and components.
