# Energy & Costs — DDNext Blueprint

**Unreleased: Version 1.0 remains unchanged until first approved release.**

Reference: [Madelena's original Energy View](https://github.com/Madelena/hass-config-public/blob/main/ui/views/energy.yaml). The design follows its actual composition: a **wide power-flow visualization**, compact summary tiles alongside a device-share donut, and device groups below, using high-contrast dark panels and magenta/teal accents.

## Installation
The page is installed as **Energie & Kosten** in the connected Dwains Dashboard Next instance. For another installation:
https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Structure
1. The top `custom:button-card` creates an SVG **breakdown of measured device power**: summed power → Kitchen / Office / Living / Other → the eight configured devices. It uses current sensor states and does not fetch a historical dataset. On narrow screens it becomes four horizontal group bars.
2. Under it are four compact KPIs: current device power, monthly measured device kWh, monthly € costs, and yearly € costs.
3. A smaller ApexCharts donut shows the **current power** percentage distribution, with a legend.
4. Below, the devices are grouped by area in four columns (two or one on narrow displays), showing device W, monthly kWh and monthly costs. Each region includes one short, two-hour power sparkline.

The dashboard **does not represent actual grid electricity flow**. Its source total is the sum of the configured device power sensors only; Hue values may be estimates. The original layout displays actual circuit and generation data, unavailable here. No invented grid source is used.

## Installed custom cards
- button-card (dynamic SVG flow)
- Mushroom Template Card (device and metric tiles)
- layout-card (responsive layout)
- apexcharts-card (live share donut)
- card-mod (dark surface treatment)
- mini-graph-card (four compact two-hour regional power sparklines)

## Performance and verification
The main flow and donut read current sensor states, not recorder long-term statistics. Only the four optional regional mini-graphs access a short two-hour history. The dynamic SVG expression was evaluated for desktop and narrow layouts before saving. The stored DDNext configuration was re-read and compared with the GitHub blueprint source. Live browser screenshots are not available via the connected Home Assistant tools.

## Versioning
Keep the blueprint at `1.0` throughout pre-release design iterations. Do not create a GitHub release until explicitly approved.
