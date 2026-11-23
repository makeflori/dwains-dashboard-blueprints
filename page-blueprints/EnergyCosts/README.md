# Energy & Costs — Dwains Dashboard Next

**Status:** Unreleased, blueprint version 1.0. Installed page: **Energie & Kosten**.

Reusable blueprint: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Current layout (2026-11-23)

### Four clickable KPI cards

**Verbrauch · Monat**, **Verbrauch · Jahr**, **Kosten · Monat**, **Kosten · Jahr** are four separate native `custom:button-card` instances. Each has its own actual Home Assistant sensor entity and `tap_action: {action: more-info}` (also for hold). This opens the Home Assistant entity **More Info/history modal**, **not** a device configuration page. The prior generated HTML `<a>` links were not reliable and have been removed. KPI cards have a consistent two-row hierarchy: icon/title above, right-aligned measured value below. Desktop uses four columns; mobile <=770px uses two columns.

### Monthly history

The left card remains a native ApexCharts column chart, with the eight cumulative energy sensors and the top five initially visible. The experimental `hidden_by_default` feature remains disabled, and a native mounted event hides the other three series once.

The separate hand-positioned month strip was removed. Statistics now align to the **start** of the calendar month (`statistics.align: start`); the native datetime x-axis labels appear with `MMM yy`, rotated -28°, while the chart span ends at the preceding complete month (`span: {end: month, offset: -1month}`). This is intended to associate month labels directly with their bars and reduce large blank end regions. **Exact browser positioning has not yet been visually confirmed**. The end-date offset is based on ApexCharts Card's documented span mechanism and can be approximate around different month lengths.

The chart tooltip is configured to hide without delay and has dedicated `mouseLeave` and `dataPointMouseLeave` callbacks, plus a non-interactive tooltip surface so it does not obstruct adjacent content.

### Responsive cost allocation and consumption table

The right side is a native interactive ApexCharts **pie** (costs in €) and a separate table with **Gerät, kWh, €, %**. The inner grid allocates up to 34% to the chart and the remaining width to the table on desktop, stacking at viewports <=980px. The pie uses `chart.width: 100%`, a smaller chart height (185px), and `customScale: 0.72` to fit the actual available column. Its default tooltip stays disabled.

The original generated HTML table has been replaced by **one native button-card per row** plus a non-interactive header. All eight device names and the monthly base-charge row now open the respective Home Assistant **entity history modal** using native `tap_action: more-info`. None navigate to the HA device configuration page. The source uses a reusable `repeat: monthly_consumption` template to map monthly sensors to rows, with matching monthly cost sensors as their additional data source.

Pie segment clicks keep selecting the corresponding table position through `data-ec-cost-index`. Selected rows have only a neutral theme background; **there is no blue border, rounded selected-row card, or separate link/button decoration**. Every row has an explicit native button-card grid layout, using the actual built-in name CSS area `n` instead of `name` and named custom fields for dot, kWh, cost and share.

## Data integrity

The current-month cost, consumption and base-charge entities were preserved. The base charge is `input_number.grundpreis_monat_strom`, confirmed in `templates.yaml`. No changes were made to any entity definition, meter, historical statistic, electricity rate, or automation.

**Known unresolved data issue:** the calculated cumulative multimedia meter used by the historical chart does not always equal the separate calibrated current-month multimedia consumption sensor. The calculations were not altered in this dashboard design change.

## Dependencies

- [button-card](https://github.com/custom-cards/button-card)
- [layout-card](https://github.com/thomasloven/lovelace-layout-card)
- [apexcharts-card](https://github.com/RomRider/apexcharts-card)
- [vertical-stack-in-card](https://github.com/ofekashery/vertical-stack-in-card)
- [card-mod](https://github.com/thomasloven/lovelace-card-mod)

## Verification and limitations

The installed DDNext source was read back and confirmed byte-for-byte identical to the GitHub YAML. All four KPI cards and nine entity rows have `more-info` native actions and valid resolved entity IDs. The cost chart is limited in width, and all device row CSS areas have been checked for consistency.

**Browser rendering and actual tap/hover behavior cannot be verified through the connected HA MCP screenshot capability**, which is disabled in this setup. In particular, the exact native monthly tick positions, tooltip exit behavior, and overlay-free pie sizing still need a real-device visual check.
