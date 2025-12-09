# Interactive Optical Tweezers Simulation

A real-time interactive simulation of optical tweezers (optical traps) using Python. Grab and manipulate a colloidal particle to observe trap dynamics, escape behavior, and thermal fluctuations.

## Features

🎯 **Interactive Particle Manipulation**
- Click and drag the particle to move it around
- Release inside the trap zone → particle bounces back to center
- Release outside the escape zone → particle escapes the optical trap
- Drag escaped particles back to recapture them

📊 **Real-time Visualization**
- **Top-down view**: See particle position and trajectory
- **Time series**: Track x-position over time relative to trap center
- **Histogram**: Distribution of particle positions (compared with Boltzmann theory)
- **Status indicators**: Visual feedback on trap state (trapped/dragging/escaped)
- **Force visualization**: Green arrow showing trap force magnitude and direction in real-time (piconewtons)

⚙️ **Physical Accuracy**
- Langevin equation with proper trap stiffness
- Realistic Brownian motion from thermal fluctuations
- Escape dynamics based on trap potential
- Boltzmann distribution for equilibrium predictions

## Requirements

- Python 3.8+
- NumPy
- Matplotlib
- SciPy

## Installation

```bash
git clone https://github.com/aliazadbakht/optical-tweezers-simulation.git
cd optical-tweezers-simulation
pip install -r requirements.txt
```

## Usage

Simply run the simulation:

```bash
python opticaltweezers_simulation.py
```

### Controls

| Action | Result |
|--------|--------|
| **Click particle** | Start dragging |
| **Drag** | Move particle to cursor |
| **Release inside orange circle** | Particle rebounds to trap center |
| **Release outside orange circle** | Particle escapes trap (Brownian motion only) |
| **Drag escaped particle back** | Recapture into trap |

## Physical Parameters

- **Particle**: 4 µm silica colloid
- **Laser power**: 5 mW @ 635 nm (red laser)
- **Trap stiffness**: 1.5 × 10⁻⁶ N/m
- **Temperature**: 293 K (20°C)
- **Medium**: Water (η = 0.001 Pa·s)
- **Escape radius**: 4 µm (beyond this, particle escapes)

## How It Works

The simulation integrates the Langevin equation:

$$m\frac{dv}{dt} = -\gamma v + F_{trap} + F_{thermal}$$

Where:
- $\gamma$ = friction coefficient from Stokes drag
- $F_{trap}$ = Harmonic trap force (when inside escape radius)
- $F_{thermal}$ = Random thermal forces
- $m$ = particle mass (negligible for small particles)

## Understanding the Visualization

### Trap Force Display
When dragging or holding the particle, a **green arrow** displays the trap force in real-time:
- **Arrow direction**: Points toward trap center (direction of force)
- **Arrow magnitude**: Scales with force strength
- **Force values**: Displayed in piconewtons (pN) for Fx, Fy, and |F|

The trap force follows Hooke's law: $$F = -k \cdot r$$

Where:
- $k$ = trap stiffness (1.5 × 10⁻⁶ N/m)
- $r$ = displacement from trap center

Typical force values at different positions:
- At trap center (r = 0): F = 0 pN
- At 1 µm displacement: F ≈ 1.5 pN
- At 4 µm (escape radius): F ≈ 6 pN

### Position Histogram
When the particle is trapped and near equilibrium, the histogram shows the **Boltzmann distribution** (black dashed line). This represents the theoretical probability of finding the particle at different positions due to thermal fluctuations.

The standard deviation of this distribution is:
$$\sigma = \sqrt{\frac{k_B T}{k}}$$

### Time Series
The x-position plot shows the particle's center coordinate relative to the trap center (0). The orange dashed lines indicate the escape radius boundaries.

## Applications

This simulation demonstrates:
- Optical trap fundamentals and dynamics
- Brownian motion and thermal noise
- Escape events and rare trajectory sampling
- Potential applications in:
  - Biophysics (protein pulling, molecular mechanics)
  - Colloidal science
  - Soft matter physics
  - Single-molecule studies

## Tips for Exploration

1. **Gentle Release**: Release the particle just outside the trap → watch it hover around the boundary before escaping
2. **Hard Pull**: Drag far and release → observe escape with asymmetric trajectory
3. **Recapture**: Escape a particle and drag it slowly back to observe re-entry dynamics
4. **Thermal Fluctuations**: At rest in the trap, the particle jitters randomly - this is Brownian motion!

## License

This project is released under the MIT License. See LICENSE for details.

## Author

Created for educational purposes in optical trapping and computational physics.

## References

- A. Ashkin, J. M. Dziedzic, J. E. Bjorkholm, and S. Chu, "Observation of a single-beam gradient force optical trap for dielectric particles," Opt. Lett. 11, 288-290 (1986)
- K. Berg-Sørensen and H. Flyvbjerg, "Power spectrum analysis for optical tweezers," Rev. Sci. Instrum. 75, 594-612 (2004)
- W. J. Greenleaf, M. T. Woodside, and S. M. Block, "High-resolution, single-molecule measurements of biomolecular motion," Annu. Rev. Biophys. Biomol. Struct. 36, 171-190 (2007)
