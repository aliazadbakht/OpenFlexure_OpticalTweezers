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

Passive microrheology extracts viscoelastic properties from the thermal fluctuations of embedded probe particles. The Mean Square Displacement (MSD) is related to the complex modulus through the Generalized Stokes-Einstein Relation:

```
G*(ω) = kT / (πa · iω · <Δr²(1/ω)>)
```

Where:
- `G*(ω) = G'(ω) + iG''(ω)` is the complex modulus
- `a` is the particle radius
- `<Δr²>` is the MSD

### Dynamic Moduli

- **G' (Storage Modulus)**: Elastic/solid-like response - energy stored per cycle
- **G'' (Loss Modulus)**: Viscous/liquid-like response - energy dissipated per cycle

### Maxwell Model

For viscoelastic media, we use the Maxwell model:

```
G'(ω) = G₀ · (ωτ)² / (1 + (ωτ)²)
G''(ω) = G₀ · (ωτ) / (1 + (ωτ)²) + ωη_s
```

Where:
- `G₀` is the plateau modulus
- `τ` is the relaxation time
- `η_s` is the solvent viscosity

### Complex Viscosity

```
|η*(ω)| = √(G'² + G''²) / ω
```

For Newtonian fluids: `|η*| = η` (constant)
For viscoelastic fluids: `|η*|` decreases with frequency (shear thinning)

## Medium Properties

| Medium | η (Pa·s) | G₀ (Pa) | τ (s) | Behavior |
|--------|----------|---------|-------|----------|
| Water | 0.001 | 0 | — | Newtonian |
| 50% Glycerol | 0.006 | 0 | — | Newtonian |
| 80% Glycerol | 0.06 | 0 | — | Newtonian |
| PEO 0.1% | 0.003 | 0.5 | 0.01 | Weak viscoelastic |
| PEO 1% | 0.01 | 5 | 0.1 | Moderate viscoelastic |
| PEO 5% | 0.05 | 50 | 1.0 | Strong viscoelastic |
| Agarose 0.1% | 0.002 | 10 | 10 | Soft gel |
| Agarose 1% | 0.005 | 500 | 100 | Stiff gel |

## Usage

### Running Locally (Python)

```bash
pip install numpy matplotlib scipy
python microrheology_simulation.py
```

### Web Version (PyScript)

Simply open `microrheology_simulation.html` in a modern web browser. No installation required!

The first load takes 10-30 seconds as PyScript downloads the Python runtime.

### Deploying to GitHub Pages

1. Copy `microrheology_simulation.html` to your repository root as `index.html`:
   ```bash
   cp microrheology_simulation.html index.html
   ```

2. Push to GitHub and enable GitHub Pages in repository settings.

3. Access at: `https://yourusername.github.io/your-repo/`

## What to Explore

### 1. Newtonian vs Viscoelastic
- Start with **Water**: G' ≈ 0, only G'' (viscous loss)
- Switch to **PEO 1%**: Both G' and G'' are significant
- Notice the crossover frequency where G' = G''

### 2. Viscosity Effects
- Compare **Water** → **50% Glycerol** → **80% Glycerol**
- Watch how Brownian motion slows dramatically
- |η*| increases but remains frequency-independent

### 3. Gel Behavior
- Try **Strong Gel (Agarose 1%)**
- G' >> G'' at all frequencies (solid-like)
- Very restricted particle motion

### 4. Relaxation Time
- Compare polymers with different τ values
- Short τ (PEO 0.1%): Crossover at high frequency
- Long τ (Agarose): Crossover below measurement range

## Files

| File | Description |
|------|-------------|
| `microrheology_simulation.html` | PyScript web version (standalone) |
| `microrheology_simulation.py` | Python/Matplotlib version |
| `microrheology_simulation.jsx` | React component version |
| `README.md` | This documentation |

## Applications

This simulation demonstrates principles used in:

- **Biophysics**: Cell mechanics, cytoplasm rheology
- **Soft Matter**: Polymer solutions, hydrogels
- **Pharmaceutical**: Drug delivery gel characterization
- **Food Science**: Texture analysis
- **Materials Science**: Complex fluid characterization

## References

1. Mason, T. G., & Weitz, D. A. (1995). "Optical Measurements of Frequency-Dependent Linear Viscoelastic Moduli of Complex Fluids." Physical Review Letters, 74(7), 1250.

2. Squires, T. M., & Mason, T. G. (2010). "Fluid Mechanics of Microrheology." Annual Review of Fluid Mechanics, 42, 413-438.

3. Cicuta, P., & Donald, A. M. (2007). "Microrheology: a review of the method and applications." Soft Matter, 3(12), 1449-1455.

## License

This simulation is part of the OpenFlexure Optical Tweezers project and is licensed under the CERN Open Hardware Licence Version 2 - Strongly Reciprocal (CERN-OHL-S v2).

## Author

Created for educational purposes in optical trapping and microrheology.

---

**Questions?** Open an issue on the GitHub repository!