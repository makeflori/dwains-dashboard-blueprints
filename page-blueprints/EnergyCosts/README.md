# Energy & Costs — Dwains Dashboard Next

**Status: unreleased, version 1.0.** Keep the version at 1.0 until the initial release is explicitly approved.

## Purpose

A compact, grid-meter-independent view of current device electricity consumption, available device cost sensors and the last 12 months of energy usage.

Import URL:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

Dwains Dashboard Next's default gallery points to the upstream blueprint repository. The blueprint is already installed as the page **Energie & Kosten** in the target DDNext dashboard and can also be imported via URL elsewhere.

Required HACS frontend cards: **layout-card** and **apexcharts-card**. The summary and device table use Home Assistant's native markdown card with Jinja templates (no button-card JavaScript).

## Visual layout

Only three principal components, no duplicate page title or hero:

1. A compact native Markdown summary table with month/year energy and cost values.
2. One 12-month stacked bar chart. Eight color-coded energy meter series share the same palette as the device list. Historical negative meter corrections are suppressed as missing observations, not misrepresented as negative or zero consumption. The horizontal axis displays month and year, such as `Jan 26`.
3. A compact native Markdown table showing current monthly kWh and known monetary device costs. A dash means no cost sensor was configured. The rows are sorted by consumption.

On wide displays, the chart and device comparison are adjacent. On narrow displays, they stack. The layout favors scanning information over decorative cards.

The eight device-month sensors and eight lifetime energy meters in the installed page are existing Home Assistant entities. Monthly cost sensors are separately configured for four devices; no missing monetary values are fabricated. The four total KPI sensors are independent of a grid-source registration.

## Configuration inputs

| Input | Value |
|---|---|
| `total_energy_month` | Current monthly total, kWh |
| `total_cost_month` | Current monthly total, EUR |
| `total_energy_year` | Current yearly total, kWh |
| `total_cost_year` | Current yearly total, EUR |
| `monthly_consumption` | Per-device monthly kWh sensors (entity-list) |
| `monthly_costs` | Per-device monetary cost sensors (entity-list); names must match the monthly consumption entries |
| `cumulative_meters` | Per-device lifetime kWh meters with recorder long-term statistics for the 12-month chart |

Do not select monthly-reset utility meters for the historical chart. The chart uses statistics of cumulative counters.

## Limitations

This blueprint is a read-only visualization. It does not change recorder statistics, energy-source settings, cost calculations or technical entity IDs. A total monetary sensor may include fixed standing charges; the sum of individually selected device costs is not intended to equal that total. Historical cost correctness depends on the underlying Home Assistant sensors retaining past tariffs.

Visual verification in a live browser is not currently available because Home Assistant's dashboard screenshot option is disabled. The two Jinja templates were executed against live Home Assistant sensor states and the dashboard configuration was checked after saving.
