# Energy & Costs — Dwains Dashboard Next

**Status:** Unreleased; blueprint version 1.0.

Installed DDNext page: **Energie & Kosten**. DDNext saves both the embedded blueprint YAML and resolved cards. An existing page requires updating both; changing only GitHub does not apply the new layout automatically.

Blueprint: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Layout

1. **Four consistent KPI cards:** Verbrauch · Monat, Verbrauch · Jahr, Kosten · Monat, Kosten · Jahr. Each has a **large left-hand icon** and **right-aligned** value, with no vertical accent stripe. All follow HA light/dark theme colors.
2. **Verbrauch · Monatsverlauf:** Taller ApexCharts plot (325px chart height), explicit left y-axis title **kWh** and data-dependent Y maximum. Six calendar-month statistical comparisons of eight cumulative device energy meters, with the current top five visible initially. The other three remain switchable via the legend.
3. **Month-axis alignment:** The historical series use monthly recorder aggregates aligned to the *middle* of each month. The ApexCharts x-axis is configured as **category with ticks on the data points**, instead of independent automatically positioned datetime ticks. The category formatter renders German month and two-digit year; the goal is one label directly under each month's bar group. The browser rendering of this non-default axis must still be visually verified.
4. **No unnecessary numbers in the legend:** Series names and their shared colors remain; legend values are disabled. Hover tooltips on the actual bars still show monthly statistical kWh.
5. **Interactive Kostenverteilung · aktueller Monat:** The donut uses device monthly EUR costs plus the verified standing-charge helper. Each colored SVG segment grows on hover or keyboard focus and has a native tooltip with the cost and, for devices, its corresponding current-month kWh.
6. **Expanded comparison table:** Name, **kWh**, cost share and EUR amount, all aligned appropriately. The standing-charge row has no fictional kWh.
7. **Redundant device and room cards removed:** Every device's current-month consumption and cost is available in the cost distribution table, so the separate room-based five-column card section and the five obsolete grouping selectors were removed. The mobile bottom spacer is retained.

## Difference between the chart and current device values

The historical chart uses **cumulative energy meter monthly recorder differences**. The current-month values in the table use the existing **monthly consumption sensors**. These are not equivalent data sources and can disagree. For example, on 2026-11-22:
- Multimedia cumulative meter `sensor.energy_total_multimedia_calculated`: recorder reported a month-to-date change of about **12.73 kWh**.
- Multimedia monthly entity `sensor.verbrauch_monat_multimedia_kalibriert`: **11.65 kWh**.

The current-month sensor's own long-term monthly statistics have very short coverage, so replacing the cumulative historical series with that monthly sensor would lose the historical record. The underlying cost and consumption sensors were not modified. Disabling legend values avoids suggesting that these distinct figures are necessarily equal.

## Cost interpretation

The actual `input_number.grundpreis_monat_strom` helper was verified at **13.90 EUR/month**. `templates.yaml` establishes that the total monthly cost sensor includes this standing charge, with possible correction inputs. The chart uses this helper as an independently labeled **Grundpreis**, not a guessed residual. Additional unexplained costs (if larger than a small rounding threshold) would be labeled **Weitere Kosten**.

## Dependencies

- [button-card](https://github.com/custom-cards/button-card)
- [layout-card](https://github.com/thomasloven/lovelace-layout-card)
- [apexcharts-card](https://github.com/RomRider/apexcharts-card)
- [card-mod](https://github.com/thomasloven/lovelace-card-mod)

## Technical checks

The GitHub source and installed DDNext source were compared for exact equality. The stored card configuration keeps eight monthly consumption sensors, eight monthly costs, eight historical meters and the verified monthly standing charge. Both JavaScript HTML card templates compiled and returned markup with synthetic state values. The installed dashboard strategy was updated using optimistic locking.

**Browser screenshot verification remains unavailable in the HA MCP connection.** In particular, verify the monthly column groups and their newly configured category x-axis, and the hover state of the donut segments, in an actual browser.
