# Energy & Costs — Dwains Dashboard Next

Version **1.1.0**. A responsive energy page with differentiated consumption and cost views, without requiring a household grid meter.

## Install

Open the blueprint page **Energie & Kosten** in Dwains Dashboard Next, or import the page YAML directly:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

The Dashboard Next stock gallery loads the official blueprint repository; this fork's entries are not automatically displayed there.

Requires **button-card**, **layout-card**, and **apexcharts-card**. All three were present in the target Home Assistant installation when version 1.1.0 was prepared.

## Layout and data sources

- Four headline tiles for month/year consumption and costs. The total cost sensors may **include the electricity base fee**; the tiles label that clearly.
- Monthly energy distribution for any number of chosen device-month kWh sensors, shown with a donut chart, ranked horizontal bars, values and shares.
- Monthly device costs, shown separately with a donut chart and comparison bars. These include only devices for which a cost sensor is provided. They do **not** silently claim to equal the total monthly cost including a base fee.
- Twelve-month chart using Home Assistant long-term statistics via ApexCharts. Select **cumulative energy meters only**, and only those whose monthly changes have been checked for valid nonnegative values.

All per-device values are taken from current sensor states, not fabricated from a grid consumption sensor.

## Verified example configuration

The installed copy uses the eight monthly energy consumers currently configured in the energy dashboard. The selected device-cost sensors are Multimedia, 3D-Drucker, Hue, and Schreibtisch-Technik. The historical chart uses only:

- `sensor.energy_total_multimedia_calculated`
- `sensor.energy_total_hue_estimated`
- `sensor.verbrauch_gesamt_siebtraeger`

These three have nonnegative monthly long-term statistics in the checked twelve-month history.

Other meters are excluded from the historical comparison for now because some recorded negative month changes (e.g. during meter migration or corrections). Such entries are **not valid negative consumption** and should be corrected in their statistics before adding them to historical comparisons.

## Historical cost accuracy

The page displays cost sensors exactly as configured. It does not calculate previous months using today's rate. Where rates changed, the underlying cost-sensor calculation or an archived cost ledger must preserve historical tariffs. The month/year headline cost figures should be audited separately if they appear inconsistent.

## Implementation details

- All card visuals use themed colors and responsive layouts. No fixed black text or black icons.
- Input lists for monthly consumption, monthly costs, and historical meters are user-configurable.
- Does not modify Home Assistant recorder, statistics, energy source settings, hardware counters, or cost formulas.
