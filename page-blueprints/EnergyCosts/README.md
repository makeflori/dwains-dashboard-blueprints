# Energy & Costs — DDNext

**Status: unreleased, blueprint version 1.0.**

The installed page **Energie & Kosten** has its own saved blueprint YAML and resolved card configuration. Both need to be changed together when updating an already-installed DDNext page.

Blueprint: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Design and responsive behaviour

- Four equally styled KPI cards show **Verbrauch · Monat**, **Verbrauch · Jahr**, **Kosten · Monat**, **Kosten · Jahr**. Desktop: four columns; mobile up to 770 CSS pixels: **two columns, two rows**, consumption above costs. Each KPI is internally two-row, with the icon and title together, the numerical value separately right-aligned.
- **Verbrauch · Monatsverlauf:** six recent calendar months. Instead of the earlier crowded seven-month annotations, the view uses short German month labels and lightly dashed calendar boundaries; labels are styled with a -35° angle. The chart plot height is 290px, with a dynamic native ApexCharts Y axis, no fixed maximum, and normal-weight `kWh` labelling.
- The eight historical sources remain available; by default **five** are shown. The three remaining consumers are initially hidden by a native ApexCharts `mounted` event calling `hideSeries(name)`, rather than the card's `experimental.hidden_by_default` feature. This was changed because that experimental feature explicitly warns that it can break auto-scaling and automatic column widths. After a legend toggle, the native chart should recalculate the data scale and column widths. **This behaviour is not yet browser-verified.**
- The monthly history is populated from HA recorder's `statistics: change` / `period: month` on cumulative energy sensors, not inferred from current monthly cost sensors.
- **Verbrauch & Kosten · aktueller Monat:** a native ApexCharts **pie**, not a donut. Its nine cost slices represent eight device cost sensors plus the separately verified monthly electricity base charge. The companion table is preserved: **Gerät | Verbrauch | Kosten | Anteil**. The pie legend stays hidden because the table already provides names and values.
- The pie's custom tooltip shows the device name, **Verbrauch** (kWh), **Kosten** (€) and **Anteil** (%). Consumption is resolved from the corresponding current HA monthly-consumption sensor through the frontend's live `hass.states`, so it is not hard-coded. If the frontend's top-level `hass` object is inaccessible, consumption falls back to an en dash; this compatibility point still requires browser verification.
- The outer panel titles, backgrounds and borders follow the Home Assistant theme. Room/device tile groups remain removed as redundant. The mobile bottom-navigation spacer is retained.

## Sources and data integrity

Eight current-month usage sensors, eight current-month cost sensors, eight cumulative historical sensors and the known standing charge (`input_number.grundpreis_monat_strom`) were retained.

The installed configuration historically displays different consumption figures for Multimedia because the cumulative historical source and the separately calibrated current-month entity do not share the same calculation. No sensor definition, tariff, or recorder statistic was modified during this redesign.

## Dependencies

- [button-card](https://github.com/custom-cards/button-card)
- [layout-card](https://github.com/thomasloven/lovelace-layout-card)
- [apexcharts-card](https://github.com/RomRider/apexcharts-card)
- [vertical-stack-in-card](https://github.com/ofekashery/vertical-stack-in-card)
- [card-mod](https://github.com/thomasloven/lovelace-card-mod)

## Validation

GitHub and installed DDNext blueprint sources were compared and found identical. The compiled KPI HTML contains the expected 2×2 mobile and four-column desktop rules; the ApexCharts event that initially hides the bottom three series and the custom pie tooltip were executed in an isolated JavaScript smoke test. The dashboard configuration was saved successfully.

**Not yet confirmed:** rendering and legibility of the month labels, actual legend-driven Y-axis and bar-width updates, and live kWh values in the tooltip on the user's iPhone. The HA connection does not currently expose browser screenshots.
