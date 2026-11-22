# Energy & Costs — DDNext

**Status: unreleased, version 1.0.** Do not bump version before the initial release is approved.

The design references [Madelena's Home Assistant Energy View](https://github.com/Madelena/hass-config-public/blob/main/ui/views/energy.yaml). It follows the hierarchy of a compact top-flow visualization, a side-by-side summary/history row, and grouped device cards. It does not reproduce the example's network/source-to-circuit flows, because those meters are not available in this Home Assistant installation.

## Install

The page is already installed as **Energie & Kosten** in the target Dwains Dashboard Next system. To import elsewhere use:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Structure

1. **Monthly consumption breakdown:** a compact, responsive flow diagram based on current device **month-to-date kWh** sensors. Source = measured/estimated consumption of configured devices; five actual/multi-room groupings; leaves = individual devices. Areas and devices are sorted by current monthly kWh, and line widths express relative energy amount. On narrow screens the same data is a ranked horizontal bar chart to avoid unreadable SVG details. Colors are accents; surfaces, text and borders follow the Home Assistant light/dark theme.
2. **Summary beside history:** three concise KPIs (monthly monetary costs, annual kWh consumption and annual monetary costs) alongside a compact history graph on desktop; stacked on mobile. The monthly kWh total is already present in the flow, so there is no redundant fourth KPI.
3. **Historical consumption:** one native `statistics-graph` with a fixed-height 295px card and explicit `stat_types: [change]`, using twelve months of grouped monthly changes from three cumulative source meters: Multimedia, Hue and Siebträger. The three-series history is a *partial device comparison*, not a complete household total.
4. **Device groups:** three wider columns at typical desktop widths (one column on phones), grouped as Kitchen, Office, Living room, Bathroom and cross-room lighting (actual HA room grouping). Eight Mushroom device tiles display kWh and EUR side by side, without duplicating live power readings which are currently mostly unavailable.

Only one proportion breakdown exists; monetary shares are not presented as a second copy of energy shares. Costs are displayed as **EUR absolute figures**, not artificially treated as separate patterns when the same electricity rate applies to all devices.

The historical source card still requires native long-term statistics and may load more slowly than the live overview; the main flow and device tiles require **no recorder history**.

## Actual data

All eight monthly kWh and EUR device sensors returned current values on 2026-11-22. The historical cumulative energy series for Multimedia, Hue and Siebträger had usable monthly changes; other sources were not included due to historical meter resets or corrections. No historical cost graph is displayed, because it cannot be reliably reconstructed from the available cost statistics without incorrectly assigning today's rate to older months.

## Dependencies

- button-card: theme-aware dynamic SVG/monthly group bars
- Mushroom Template Card: KPI and device entries
- layout-card: intrinsic responsive card groups
- `statistics-graph`: native Home Assistant component

## Verification and limitations

The JS for the flow was evaluated against actual HA entity states in narrow and wide simulated window sizes, and all 11 Jinja KPI/device templates were executed successfully. The installed DDNext page source matches the GitHub YAML. The exact visual rendering in the user's browser cannot be verified without screenshot functionality.

This is **not an actual energy transfer/grid Sankey**. No unsupplied grid, circuit, solar or tariff data are fabricated.
