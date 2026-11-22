# Energy & Costs — Dwains Dashboard Next

**Status: Unreleased version 1.0.** This blueprint is iterated without changing its version before the first approved release.

## Installation

This page is already installed as **Energie & Kosten** in the connected DDNext dashboard. For other installations, import the YAML from:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

DDNext's stock gallery uses the upstream registry, not this fork.

## Visual structure and theme

The page respects Home Assistant's active **light/dark theme**, relying on native Mushroom styles and Home Assistant CSS variables for foregrounds, backgrounds and dividers. No hard-coded dark card backgrounds.

1. **Current power breakdown** as a custom button-card display. On mobile it is a set of horizontal bars, sorted **descending by watts**, re-sorted whenever the configured power entities update. On wide screens it becomes a power breakdown from the summed devices to areas and individual devices.
2. **Four concise overview cards** for monthly kWh, monthly €, yearly kWh and yearly €.
3. **Five configured groups** based on the connected Home Assistant installation: Küche, Büro, Wohnzimmer, Bad, and Raumübergreifend. Eight device cards show monthly kWh, cost €, and current W.

The room lists are configurable blueprint inputs. The reference installation's mapping was verified against Home Assistant's area and device registries. Hue total is not assigned to an invented room: it is marked **Raumübergreifend**.

**There is no redundant donut or four mini-graph cards.** Those charts previously caused slow/empty loading and provided little additional information. The current page only uses live state data, with no chart history fetches.

## Inputs

- `total_energy_month`: monthly total energy sensor.
- `total_cost_month`: monthly total cost sensor.
- `total_energy_year`: yearly total energy sensor.
- `total_cost_year`: yearly total cost sensor.
- `current_power`: list of live power (W) sensors with consistent device names.
- `monthly_costs`: list of per-device monthly monetary sensors; matched to device names.
- `kitchen`, `office`, `living`, `bathroom`, `other`: room/other grouping with monthly kWh sensors and display icons.

Use each named device only once across groups. The breakdown reflects the **sum of configured devices**, not a physical grid-consumption meter. No network import/export, solar generation or circuit-level flow is inferred.

## Dependencies

- button-card (single lightweight live breakdown)
- Mushroom Template Card (overview and device cards)
- layout-card (intrinsic responsive grid)

These were present in the target Home Assistant instance. There is no apexcharts-card or mini-graph-card dependency for this blueprint.

## Validation

The live breakdown's JS was executed with actual power sensor states in mobile and desktop viewport simulations. All 12 Mushroom Jinja templates were evaluated against Home Assistant's current sensor states. The installed DDNext page and the GitHub YAML were written as the same source and should be rechecked after installation.

**Rendering limitations:** A true browser screenshot of the installed page is not available through the connected tools, so visual appearance must still be checked on the actual device.

## Version

Keep `version: "1.0"` during pre-release design iterations. Do not create a GitHub release until explicitly approved.
