# Energy & Costs — Dwains Dashboard Next

**Status: unreleased; Blueprint version 1.0.**

The installed page **Energie & Kosten** stores its blueprint source and resolved cards in the DDNext dashboard strategy. Both must be updated to propagate changes to an already-installed page.

Source: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Visual structure

- **Four KPI cards:** Desktop has four columns; mobile widths at or below 770px have two columns (consumption row, costs row). Each card includes a small icon and title in the top line, and a large, right-aligned number below.
- **Verbrauch · Monatsverlauf:** A native ApexCharts historical column chart for six calendar months and eight configured cumulative energy meters. Its graph area is fixed-height; the y-axis uses an ApexCharts `max` callback with an 10% headroom over the data maximum and no forced nice-scale rounding. This is intended to use more of the available plot when the largest series is hidden.
- **Month labels:** The previous floating ApexCharts annotation labels were visibly broken on mobile and have been completely removed. Instead, a separate six-column month strip, calculated from the user's current calendar month, appears **below the plotting area**. The chart legend is placed above the plot so this strip is not pushed below the legend. Month names are short, rotated -23°, with no annotation lines crossing the plot.
- **Top-five selection:** The installed chart initially hides the last three historical series using the native ApexCharts `hideSeries` method on `mounted`. The three remain in the regular legend and can be toggled at any time. This avoids the `experimental.hidden_by_default` option, which has documented scaling and bar-width limitations.
- **Verbrauch & Kosten · aktueller Monat:** A native interactive ApexCharts pie represents monthly EUR cost slices for eight devices and the verified Grundpreis. The table below/alongside it retains **Gerät | Verbrauch | Kosten | Anteil**, using actual configured monthly sensors.
- **Click-to-select:** Native pie tooltips are **disabled**. Clicking a pie segment invokes the chart's `dataPointSelection` event, looks for the corresponding table row by a stable `data-ec-cost-index` marker, highlights it with the HA theme's secondary background and accent bar, and scrolls it into view on small screens. This handler has passed a DOM mock test, but cross-component event lookup must still be verified in the live HA browser.
- The two analysis cards preserve coordinated titles, background, borders and rounded corners; the room-device section remains removed.

## Data assumptions and limitations

The monthly plot uses Home Assistant recorder `statistics: change`, `period: month` from cumulative energy meters. Current-month table values use separate monthly-consumption sensors. They are **not** necessarily identical. In particular, Multimedia's cumulative-meter monthly statistics and calibrated current-month sensor disagree; their calculation definitions were not changed.

The Grundpreis is read from `input_number.grundpreis_monat_strom`; it is never inferred as an unexplained cost residual. All existing consumption and cost sensor references are unchanged.

**Important:** The standalone month-strip labels use the six calendar months ending with the local current month. They approximate the chart plot's horizontal inner spacing; true pixel-perfect placement, live touch selection and dynamic y-axis recalculation cannot be verified without checking the actual frontend. The Browser screenshot capability is disabled for the connected HA instance.

## Dependencies

- [button-card](https://github.com/custom-cards/button-card)
- [layout-card](https://github.com/thomasloven/lovelace-layout-card)
- [apexcharts-card](https://github.com/RomRider/apexcharts-card)
- [vertical-stack-in-card](https://github.com/ofekashery/vertical-stack-in-card)
- [card-mod](https://github.com/thomasloven/lovelace-card-mod)

## Technical validation

DDNext and GitHub blueprint source matched exactly after saving. Both the month-strip template and the table's per-row HTML markers were generated successfully. The pie's `dataPointSelection` handler was invoked with a mock document and highlighted only the selected row. The table's device values, costs, and percentages remain sourced from the same eight monthly device inputs and the standing charge.

## Layout and navigation update — 2026-11-23

- Desktop cost pie and table use an asymmetric inner grid (`minmax(0, 1fr) minmax(0, 1.5fr)`), giving the table greater width and keeping the pie confined to its column. On narrow viewports (up to 1000 CSS pixels), the two components stack. Pie height is 220px with `customScale: 0.81`. Both components are width constrained.
- The selected table row now receives a theme-aware background only; the former blue/primary left border is removed.
- All four summary tiles link to their **underlying aggregate sensor's More Info** dialog. Aggregate template sensors do not have a Home Assistant device registry ID, so a physical device page cannot be assumed.
- Table device names are now links. The four with verified device-registry IDs (Kühlgefrierschrank, Siebträger, Waschmaschine, Testaufbau) navigate to `/config/devices/device/<device_id>`. The remaining names open their monthly consumption entities' More Info dialog instead of fabricating a device registry relationship.
- Current event wiring uses `hass-more-info` for virtual/aggregate sensor links; a `more-info-entity-id` query parameter is provided as a fallback. Browser interaction remains to be confirmed.

**Browser screenshot checks are not available through the current HA connection**, so exact desktop pie/table sizing and link interactions have not been visually validated.
