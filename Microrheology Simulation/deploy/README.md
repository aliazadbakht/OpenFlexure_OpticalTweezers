# Optical Tweezers Microrheology Simulation

An interactive simulation demonstrating passive microrheology using optical tweezers. Probe the viscoelastic properties of different media by analyzing the Brownian motion of a trapped bead.

## Features

🔬 **Multiple Media Types**
- **Newtonian Fluids**: Water, 50% Glycerol, 80% Glycerol
- **Viscoelastic Polymers**: Dilute PEO (0.1%), Semi-dilute (1%), Entangled (5%)
- **Gels**: Weak Agarose (0.1%), Strong Agarose (1%)

📊 **Real-time Visualizations**
- **Trapped Bead**: Watch Brownian motion change with medium properties
- **Dynamic Moduli**: G'(ω) and G''(ω) vs frequency (log-log plot)
- **Complex Viscosity**: |η*(ω)| vs frequency
- **Mean Square Displacement (MSD)**: Computed from particle trajectory

⚙️ **Physical Parameters**
- 2 µm silica bead
- 1 pN/µm trap stiffness
- Temperature: 293 K (20°C)
- Maxwell viscoelastic model

## Physics Background

### Microrheology Principles

Passive microrheology extracts viscoelastic properties from thermal fluctuations of embedded probe particles. The Mean Square Displacement (MSD) relates to the complex modulus through the Generalized Stokes-Einstein Relation.

### Dynamic Moduli

- **G' (Storage Modulus)**: Elastic/solid-like response - energy stored per cycle
- **G'' (Loss Modulus)**: Viscous/liquid-like response - energy dissipated per cycle

### Maxwell Model

For viscoelastic media:
- Short relaxation times: Liquid-like behavior (high G'')
- Long relaxation times: Gel-like behavior (high G')
- Crossover frequency indicates transition from viscous to elastic dominance

## How to Use

1. **Launch the simulation** by opening this page
2. **Select a medium** from the dropdown to change fluid properties
3. **Observe the bead motion** - see how Brownian motion varies with media
4. **Analyze the results**:
   - MSD curve shows particle displacement behavior
   - G' and G'' show elastic vs viscous contributions
   - Compare different media to understand viscoelasticity

## Applications

This simulation demonstrates principles used in:

- **Biophysics**: Cell mechanics, cytoplasm rheology
- **Soft Matter**: Polymer solutions, hydrogels
- **Pharmaceutical**: Drug delivery gel characterization
- **Food Science**: Texture analysis
- **Materials Science**: Complex fluid characterization

## Technical Details

- **Bead diameter**: 2 µm (silica)
- **Trap stiffness**: 1 pN/µm
- **Temperature**: 293 K (20°C)
- **Simulation**: PyScript (Python in browser)

## License

This simulation is part of the OpenFlexure Optical Tweezers project and is licensed under the CERN Open Hardware Licence Version 2 - Strongly Reciprocal (CERN-OHL-S v2).

---

**Questions?** Open an issue on the GitHub repository!
