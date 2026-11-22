# Energy & Costs — DDNext

**Status:** Unreleased, blueprint version 1.0.

The installed DDNext page is **Energie & Kosten**. The dashboard strategy stores both the blueprint YAML and the resolved cards; editing GitHub alone does not update an installed page.

Blueprint: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Layout and rules

- **One unified layout:** Four matching, neutral theme-aware KPI cards in one row: **Verbrauch · Monat**, **Verbrauch · Jahr**, **Kosten · Monat**, **Kosten · Jahr**. No headings float above them.
- **Two matching analysis cards:** **Monatsverlauf** at left and **Kostenverteilung** at right. Both use matching 12px radius/border and a minimum height of 410px. The layout stacks on narrow displays.
- **Default five historical series:** The current top five monthly consumers are Multimedia, Kühlgefrierschrank, Hue-Beleuchtung, 3D-Drucker and Siebträger. The three remaining series stay in the chart legend with `show.hidden_by_default: true` and can be activated there. The historical input rows have an extra `hidden_by_default` boolean saved on the installed page. **Note:** this selection reflects the consumption ranking when the dashboard was last configured; it is not recalculated automatically every time a device changes rank.
- **Chart caveat:** ApexCharts Card's `experimental.hidden_by_default` may affect auto-scaling or automatic bar width. It is enabled here to keep unchecked series available via the legend. The Y axis remains configured with `max: auto`, but its actual behavior needs visual checking.
- **Month placement:** Monthly long-term statistics now use `align: end`, and the x-axis tick labels are transformed to refer to the corresponding preceding month, so ticks correspond to the monthly bars. This is only a display adjustment, not a change to underlying data.
- **Cost allocation rather than duplicated kWh shares:** The right donut uses **monthly cost sensor values in EUR**. Its center shows **overall monthly costs** when the total cost sensor is consistent with the listed device costs. The difference between the overall total and those eight device costs is a neutral **Nicht zugeordnet** segment, which can include fixed charges or other unmonitored usage. It must not be attributed to the eight devices. The adjacent table shows each cost and its percentage of the total, with device names left-aligned.
- **Five columns for grouped devices:** Küche, Büro, Wohnzimmer, Bad and Raumübergreifend remain the original five configured groupings, now in five side-by-side columns on desktop. Responsive breakpoints reduce the count to three, two, or one column. Device cards retain kWh / Monat and Kosten in EUR / Monat, using the same stable color per device as the chart.
- All backgrounds, borders and text use active Home Assistant light/dark theme variables.

## Data and limitations

All eight cumulative energy sensors remain configured and all original monthly consumption/cost sensors are unchanged. Historic recorder coverage differs; negative historical consumption corrections are filtered from the visualization, without changing recorder data. The chart is a comparison of eight devices, **not a complete building energy balance**.

The last verified monthly cost values (2026-11-22) were approximately **27,56 € total**, with **13,66 €** from the eight individual cost sensors and **13,90 €** not assigned to a device. This remainder is a mathematical difference, **not a determination of which physical sources incurred the charges**.

Dependencies: [button-card](https://github.com/custom-cards/button-card), [layout-card](https://github.com/thomasloven/lovelace-layout-card), [ApexCharts Card](https://github.com/RomRider/apexcharts-card). Home Assistant long-term recorder statistics are required for the monthly graph.

## Verification

After the update, the installed DDNext blueprint YAML and GitHub blueprint were confirmed identical. Eight historical series (five visible, three hidden by default), five groups and eight cost sensors were preserved. The generated KPI, cost donut and device JavaScript templates compiled and executed with test state values.

**A browser screenshot has not been verified.** The Home Assistant screenshot integration is currently disabled; the full frontend rendering, monthly tick alignment and experimental hidden-series behavior remain to be inspected visually.
