# Bill of Materials (BOM)

## Optical Components

| Item | Specification | Quantity | Where to Buy |
|------|---------------|----------|--------------|
| High-NA Objective Lens | NA ≥ 0.8, RMS threaded (search: "Plan infinity Achromatic Objective") | 1 | [AliExpress](https://nl.aliexpress.com/item/1005009852515331.html) |
| Red Laser Diode | ~1 mW (laser pointer), 635 nm typical | 1 | [Amazon](https://www.amazon.nl/-/en/dp/B07RM3RWSF?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_1) |
| Doublet Lens | Ø 12.7 mm (½"), f = 17–20 mm (search: "Double-Cemented Achromatic Lenses")| 1 | [AliExpress](https://nl.aliexpress.com/item/1005009623444048.html) |
| Doublet Lens | Ø 12.7 mm (½"), f = 50 mm (search: "Double-Cemented Achromatic Lenses")| 1 | [AliExpress](https://nl.aliexpress.com/item/1005009623444048.html) |
| Dichroic Mirror | Reflects red (~635 nm), pass blue, green 15x10x1.1mm  | 1 | [AliExpress](https://nl.aliexpress.com/item/4000835210707.html) |

## 3D-Printed Parts

| Item | File Location | Quantity | Where to Buy |
|------|---------------|----------|--------------|
| Optical Cube | `stl/` folder | 1 | N/A - Print yourself |
| Cube-Laser Coupler | `stl/` folder | 1 | N/A - Print yourself |
| Laser Holder (3-screw adjust) | `stl/` folder | 1 | N/A - Print yourself |
| Additional mounting parts | `stl/OpenFlexure Optical Tweezers.3mf` | As needed | N/A - Print yourself |

## Hardware & Fasteners

| Item | Specification | Quantity | Where to Buy |
|------|---------------|----------|--------------|
| Brass Heat-Set Inserts | M3 thread | 3 | [Amazon](https://www.amazon.nl/-/en/dp/B09ZHSGHXD?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_4&th=1) |
| M3 Screws | same as used in actuators/condenser (length as needed) | 3 | |
| M2 Self-Tapping Screws | For plastic parts | 4 | |
| M3 × 6 mm Screws | Machine screws | 2 | |

## Electronics (Optional)

| Item | Specification | Quantity | Where to Buy |
|------|---------------|----------|--------------|
| DC-DC Buck/Boost Converter | Adjustable output to match laser voltage | 1 | [Amazon](https://www.amazon.nl/-/en/dp/B0D7BWSTCX?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_3) |
| USB Power Adapter | 5V output (if powering via USB) | 1 | |

## Notes

- **Objective Lens**: Must be high numerical aperture (NA ≥ 0.8) for effective optical trapping. RMS thread compatible with OpenFlexure microscope.
- **Laser Safety**: Use appropriate eye protection when working with lasers, even low-power ones.
- **3D Printing**: All STL files are in the `stl/` folder. Print with standard PLA or PETG.
- **Brass Inserts**: Install with soldering iron or heat-set tool before assembly.
- **DC-DC Converter**: Only needed if your laser operating voltage differs from your power supply (e.g., laser needs 3V but you have 5V USB).

## OpenFlexure Base Components

This extension requires a complete OpenFlexure Microscope base. See the [OpenFlexure documentation](https://openflexure.org/projects/microscope/) for the full microscope BOM.
