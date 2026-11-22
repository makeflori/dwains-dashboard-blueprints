# Energy & Costs — Dwains Dashboard Next

**Status: unreleased, blueprint version 1.0.**

The installed DDNext page is **Energie & Kosten**. Both its embedded YAML and the resolved page cards are persisted in the dashboard strategy. Editing the GitHub source alone does not update an already-installed page.

Source: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Dashboard design

- **Two columns, one consistent hierarchy:** *Verbrauch* on the left (Monat, Jahr), *Kosten* on the right (Monat, Jahr). The four KPIs have identical typography and neutral Home Assistant theme backgrounds, with no arbitrary accent colours.
- **Monthly history:** Left chart uses the installed [ApexCharts Card](https://github.com/RomRider/apexcharts-card). It reads eight cumulative energy meters using the recorder's monthly `change` statistics. A **data-dependent y-axis** starts at zero and adapts to the positive values on display, with no fixed maximum. Older negative changes are not plotted as electricity consumption. Data is cached, with an update interval of ten minutes.
- **Consumption shares and costs:** Right card has one large donut showing the month-to-date share of each recorded device. The full legend now includes each device's share and absolute **monthly EUR cost**. Total recorded device costs are labelled separately from the overall monthly costs KPI. There is no redundant second cost-share chart.
- **One colour per device:** The eight chart series use a declared `color_list`; donut and device cards use the **same palette, keyed by the corresponding historical-series name**. Historical-series order determines the chart palette; keep the historic list's device names consistent with the current-month list when editing inputs.
- **Compact grouped device cards:** The five user-configured groups now use responsive columns with a 215px minimum where space permits; cards show device name, kWh / Monat and EUR / Monat with a matching colour marker. The obsolete percentage bars are removed.
- **Consistent titles:** The left chart uses the native ApexCharts standard header; the right card uses a similarly aligned, left-justified heading. Both follow the active Home Assistant light/dark theme.
- **Mobile layout:** Consumption and cost groups reflow to one column, as do the two analysis cards. Grouped device columns adapt to available width.

## Data caveats

All eight historical sources are configured. Recorder statistics were checked on 2026-11-22. Historical coverage differs by source: 3D printer and desk have brief histories, while refrigerator, washing machine and test setup have older negative changes associated with resets or corrections. The graph excludes negative changes rather than inventing replacement values; it does **not** edit underlying recorder data.

Monthly consumption and monetary costs remain based on the existing user-selected Home Assistant sensors. The donut's total refers to the *eight recorded/estimated devices*, which is not necessarily the full home monthly consumption. The overall monthly amount and the sum of the eight individual costs can differ.

## Dependencies

- [button-card](https://github.com/custom-cards/button-card)
- [layout-card](https://github.com/thomasloven/lovelace-layout-card)
- [apexcharts-card](https://github.com/RomRider/apexcharts-card)
- Home Assistant recorder with compatible long-term energy statistics

## Checks

Updated GitHub YAML and the installed DDNext embedded Blueprint were read back and found identical. All eight original current-month sensors and their cost sensors remain bound; the historical chart retains eight series. The embedded JavaScript for the KPI, donut and grouped cards was independently compiled and executed using synthetic state values without syntax errors.

**The final browser rendering has not been visually confirmed**, because the HA MCP screenshot feature is disabled. Especially verify the ApexCharts monthly history layout and its data-driven y-axis in the actual DDNext frontend.
