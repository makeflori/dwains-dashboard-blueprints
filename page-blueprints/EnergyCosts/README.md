# Energy & Costs for Dwains Dashboard Next

**Unreleased version 1.0 — do not increment until the initial release is approved.**

This blueprint is a reworking inspired by the visual hierarchy of [Madelena's Home Assistant Energy View](https://github.com/Madelena/hass-config-public/blob/main/ui/views/energy.yaml): prominent live power distribution, restrained summary panels, and groups of devices by location. It is **not** a copy of Madelena's Sankey configuration: the Home Assistant instance does not have separate circuit and renewable/grid-origin measurements sufficient for a truthful energy-flow diagram.

## Install

The page is already installed in the target Dwains Dashboard Next instance as **Energie & Kosten**. To install in another dashboard use:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

The default DDNext gallery loads the upstream repository rather than this fork.

## Presentation

- Four theme-aware slim summary cards: current measured power, current month's energy and costs, and current year's costs.
- A central **current power** donut comparing eight W sensor states, with legend and a central total. The ApexCharts `data_generator` is fed only current values, not 12 months of history. Values are measured/estimated at the device level and must **not** be confused with the household grid draw.
- Four named device regions: Kitchen, Office, Living, and Other. The user configures which monthly energy sensors appear in each region. Each device card shows **W now**, **kWh this month**, and **€ this month**, using matching cost sensor names.
- No large redundant hero; the DDNext page supplies its title and icon.
- Responsive: four regional columns on wide displays, two on mid-size displays, one on mobile.
- Subtle magenta, teal, and amber accents, while preserving native light/dark theme variables.

## Configurable inputs

`total_energy_month`, `total_cost_month`, `total_cost_year` are total sensor selectors.

`current_power` is an entity list of each device's live power sensors measured in watts; it drives the donut and the live device figure. Use the same device names as in the monthly energy lists.

`monthly_costs` is a list of monetary sensors, matched by **name** to the devices in regional lists.

`kitchen`, `office`, `living`, and `other` are separate region-specific lists of monthly **kWh** sensors with icons and names. A device should appear in only one region to avoid duplicate display. A multi-room Hue total is best placed in Other.

## Dependencies

- Mushroom Template Card
- layout-card
- apexcharts-card

All were installed in the target Home Assistant instance when this version was built.

## Data integrity

The central visualization is of **current power (W)**, not a measured grid import. The monetary totals may include standing charges and are not expected to equal the sum of a subset of device costs. Hue consumption and power estimates are not physical-meter readings. The blueprint does not edit sensors, recorder, tariff logic or energy preferences.

Twelve Jinja templates were validated against the live Home Assistant sensor states prior to saving. No rendered browser screenshot of the resulting page was available.
