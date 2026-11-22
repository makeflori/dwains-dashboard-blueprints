# Energy & Costs — Dwains Dashboard Next

**Blueprint version:** 1.0 (unreleased). The installed DDNext page is named **Energie & Kosten**. Updating the existing page requires updating both its embedded YAML source and the resolved Lovelace cards stored in the DDNext strategy.

Blueprint source: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Current layout

The dashboard has **four KPI cards** above **two analysis cards**; redundant room/group cards remain removed.

### KPI cards

The four KPIs are *Verbrauch · Monat*, *Verbrauch · Jahr*, *Kosten · Monat* and *Kosten · Jahr*. Each card uses a consistent **two-row** hierarchy: icon and label together on the upper row, right-aligned numerical value below. Each device's energy and cost values retain their underlying configured Home Assistant entity.

### Verbrauch · Monatsverlauf

- Uses a native [ApexCharts Card](https://github.com/RomRider/apexcharts-card) time-series with up to seven recent calendar months. The data are Home Assistant recorder's `statistics: change`, `period: month` values for eight cumulative energy meters.
- The unreliable automatic datetime tick labels are hidden. Instead, **native ApexCharts x-axis annotations** are configured at the *exact midpoint of each calendar month* (local time), with subtle separators at each month boundary. The positions and month names are computed at card initialization for the current rolling seven-month window.
- The x-axis crosshair tooltip is explicitly disabled so the month-only popup no longer duplicates the data tooltip. The data tooltip on the actual bar still contains the historical consumption.
- The y-axis is dynamic, and the 11px kWh label uses normal font weight.
- The first five previously selected devices are shown by default, while the remaining three are available in the muted legend. Legend values are disabled.
- **Limitation:** The ApexCharts annotation placement and label visibility have not been verified in a real browser. The card computes annotations when it is instantiated; reloading after a month boundary ensures the calendar labels roll forward. This avoids substituting raw timestamps as categorical labels, which previously broke the axis.

### Verbrauch & Kosten · aktueller Monat

The right visual combines **two coordinated elements inside one panel**, instead of trying to make either the donut legend or an unresponsive SVG carry both tasks:

1. A **native, interactive ApexCharts donut** for monthly EUR costs of all eight devices plus the electricity standing charge. It has native slice hover and click behaviour and an explicit opaque, theme-aware tooltip that displays the item, amount and percentage. Its built-in legend is hidden to avoid duplicating the table.
2. A complementary, read-only **table** of the same categories: **Gerät | Verbrauch | Kosten | Anteil**. Consumption is drawn from the configured monthly kWh sensor; costs come from the configured monthly EUR cost sensor. For the Grundpreis, consumption is shown as an en dash, never an invented kWh. All column titles have the same hierarchy/weight, with numeric values aligned to the right.

The right donut and table are side by side at desktop width, stacking responsively on narrower screens. The two outer cards use the same installed `vertical-stack-in-card` grouping and their title cards share one typographic style.

**Verified cost calculation:** `input_number.grundpreis_monat_strom` is the actual monthly Grundpreis helper. Its value was 13.90 EUR when checked on 2026-11-23. The total monthly cost sensor includes the base charge and the existing device-cost components. For example, the sampled states yielded 13.73 EUR for the eight devices and 13.90 EUR Grundpreis, matching the total 27.63 EUR. This is not a guessed residual.

## Historical vs. month-to-date sensor discrepancy

The monthly trend is based on cumulative-meter long-term statistics; the table's monthly values come from separate current-month sensors. These can legitimately differ due to differing measurement periods and calibration definitions. The underlying sensor calculations were **not modified**. The previous inconsistency for Multimedia has not yet been resolved; the chart legend no longer prints a separate month-to-date value.

## Required frontend cards

- [button-card](https://github.com/custom-cards/button-card)
- [layout-card](https://github.com/thomasloven/lovelace-layout-card)
- [apexcharts-card](https://github.com/RomRider/apexcharts-card)
- [vertical-stack-in-card](https://github.com/ofekashery/vertical-stack-in-card)
- [card-mod](https://github.com/thomasloven/lovelace-card-mod)

All were present in the target Home Assistant resource list when checked.

## Validation and remaining limitations

The embedded blueprint and GitHub YAML were read back and confirmed identical. The KPI and cost-table inline JavaScript returned expected HTML when executed against available Home Assistant states. The seven month-center annotations and six boundary annotations were evaluated as dates and shown to be in the correct months. The existing page keeps all eight energy histories, eight cost and monthly-consumption values, and the standing-charge helper.

**Real browser rendering is still unverified**, as the Home Assistant MCP connection does not expose screenshots for this dashboard. In particular, confirm annotation positions within the ApexCharts plot and confirm that the two-part cost card sizes correctly in the browser.
