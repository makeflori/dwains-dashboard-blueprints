# Energy & Costs — Dwains Dashboard Next

**Unreleased blueprint, version 1.0.** Keep this version until the first release is explicitly approved.

## Installation

This page is already installed as **Energie & Kosten** in the connected Dwains Dashboard Next instance. To import it elsewhere, use:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

The default DDNext gallery uses the upstream blueprint registry, not this fork.

## Page design

The current page deliberately contains **only three informative sections**:

1. **Overview:** four small, theme-aware Mushroom cards for this month's and this year's total kWh and €.
2. **Monthly proportions:** two native Home Assistant *distribution* cards, one showing current-month kWh shares and one showing current-month € shares for all eight selected devices. These cards have interactive legends and need no custom JavaScript or historical data queries.
3. **Monthly historical consumption:** a native Home Assistant *statistics-graph* bar chart over twelve months, using only selected cumulative energy meters with usable long-term statistics.

The dashboard's own page title supplies the heading. No duplicate hero, black-only styling, room cards, live-power totals, custom flow diagrams, mini-graphs or extra per-device tiles are used.

## Important data limitations

- The two distribution charts show the **proportion within the selected devices**. The monetary chart does **not** claim to distribute the whole monthly bill or standing charges.
- The three currently validated historical consumption sources are Multimedia, Hue and Siebträger. They are **not the total electricity use of all eight devices**. Other cumulative meters have recorded negative corrections or resets that are unsuitable for an unqualified historical display.
- Historical monthly costs cannot currently be reconstructed accurately from the user's statistics: total-cost monthly statistics include resets or old frozen values, and `sensor.cost_year_total` has no useful long-term statistics. Do not multiply earlier consumption by today's electricity price.
- There is an optional `historical_cost_meters` input, but no cost-history chart is displayed unless valid cumulative cost meters are provided. The current installation has none selected.
- Power sensors that were unavailable in the last checked state are no longer used by the page. This removes misleading zero-watt readings from the visualization; the sensor availability issue remains separate.

## Inputs

- `total_energy_month`, `total_cost_month`, `total_energy_year`, `total_cost_year` — KPI sensors.
- `monthly_consumption` — monthly kWh sensor list with device names.
- `monthly_costs` — monthly monetary sensor list with device names.
- `historical_consumption_meters` — cumulative kWh sensors with verified long-term statistics.
- `historical_cost_meters` — optional cumulative € sensors with valid long-term statistics; currently unused.

## Dependencies

- Mushroom Template Card
- layout-card

`distribution` and `statistics-graph` are **native Home Assistant cards**, available in the target HA 2026.11.2 installation; the page no longer needs button-card, ApexCharts or mini-graph-card.

## Checks

The four KPI Jinja templates were executed successfully against current HA sensor states. The installed page was re-read after saving and its blueprint source was identical to GitHub. Actual live browser rendering is not available through the connected HA tools and has not been visually confirmed.

## Version

Remain at `version: "1.0"`. No GitHub release has been created.
