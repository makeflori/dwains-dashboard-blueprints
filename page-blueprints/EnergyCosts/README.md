# Energy & Costs — Dwains Dashboard Next

Version **1.2.0**. A responsive energy page with differentiated consumption and cost views, without requiring a household grid meter.

## Install

Open the blueprint page **Energie & Kosten** in Dwains Dashboard Next, or import the page YAML directly:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

The Dashboard Next stock gallery loads the official blueprint repository; this fork's entries are not automatically displayed there.

Requires **button-card**, **layout-card**, and **apexcharts-card**. All three were present in the target Home Assistant installation when version 1.1.0 was prepared.

## Layout and data sources

- Four headline tiles for month/year consumption and costs. The total cost sensors may **include the electricity base fee**; the tiles label that clearly.
- Monthly energy distribution for any number of chosen device-month kWh sensors, shown with a donut chart, ranked horizontal bars, values and shares.
- Monthly device costs, shown separately with a donut chart and comparison bars. These include only devices for which a cost sensor is provided. They do **not** silently claim to equal the total monthly cost including a base fee.
- Twelve-month chart using Home Assistant long-term statistics via ApexCharts. Select **cumulative energy meters only**. Negative correction entries are omitted from the chart as missing values, not treated as negative usage or as zero.

All per-device values are taken from current sensor states, not fabricated from a grid consumption sensor.

## Verified example configuration

The installed copy uses the eight monthly energy consumers currently configured in the energy dashboard. The selected device-cost sensors are Multimedia, 3D-Drucker, Hue, and Schreibtisch-Technik. The historical chart in the installed dashboard includes all eight configured consumption meters, and excludes invalid negative monthly statistics. Missing months are gaps, not evidence of zero consumption.

Some meters have historical resets/corrections. Their negative month changes are hidden rather than plotted below zero. Correction of the historical statistics is a separate data-quality task.

## Historical cost accuracy

The page displays cost sensors exactly as configured. It does not calculate previous months using today's rate. Where rates changed, the underlying cost-sensor calculation or an archived cost ledger must preserve historical tariffs. The month/year headline cost figures should be audited separately if they appear inconsistent.

## Implementation details

- Cards use theme-aware text, left-aligned icons and responsive layouts. The horizontal axis uses month and year (e.g. Jan 26). Extraneous headings and the clipped footer notice have been removed.
- Input lists for monthly consumption, monthly costs, and historical meters are user-configurable.
- Does not modify Home Assistant recorder, statistics, energy source settings, hardware counters, or cost formulas.
