# Energy & Costs — Dwains Dashboard Next

A reusable **page blueprint** for household device energy consumption and cost monitoring **without a whole-home grid meter**.

## Install

In Dwains Dashboard Next, open **Add blueprint**, load the YAML URL below (or select "Energy & Costs" from the gallery if Dwains Dashboard Next is configured to load this fork), configure the inputs, and save the page.

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/energy-costs/blueprint.yaml

Requires the [button-card](https://github.com/custom-cards/button-card) frontend card. Other graphs use the native Home Assistant statistics graph.

## Inputs

| Input | Purpose |
|---|---|
| Monthly energy / cost totals | Optional four headline tiles (month and year) |
| Monthly consumption by device | Any number of *monthly kWh entities*, displayed as device tiles |
| Monthly costs by device | Any number of *monetary entities*, displayed as device tiles |
| Yearly costs by device | Optional annual cost tiles |
| Cumulative energy meters | Lifetime kWh meters with **long-term statistics** for the 12-month bar chart |

Monthly consumption tiles and their source entities show the **current** month. The long-term monthly graph uses *cumulative* energy meters and Home Assistant's recorder statistics, not monthly-reset utility meters. This keeps historical monthly kWh charts meaningful.

Note: Dwains Dashboard Next's stock gallery is hardcoded to the upstream blueprint registry, not this fork. Use **Load from URL** unless your dashboard fork has been configured to use `makeflori/dwains-dashboard-blueprints`.

All `entity-list` inputs in the current DDNext editor require at least one entity; fill the consumption, cost, year-cost and cumulative-meter lists during setup.

### Example sensor selection for one Home Assistant instance

- Monthly consumption: \`sensor.verbrauch_monat_multimedia_kalibriert\`, \`sensor.verbrauch_monat_siebtraeger\`, \`sensor.verbrauch_monat_waschmaschine\`.
- Monthly costs: \`sensor.cost_month_multimedia\`, \`sensor.cost_month_3ddrucker\`, \`sensor.cost_month_huetotal\`.
- Cumulative meters: \`sensor.energy_total_multimedia_calculated\`, \`sensor.energy_total_hue_estimated\`, \`sensor.verbrauch_gesamt_siebtraeger\`.
- Yearly totals: \`sensor.energy_year_total\`, \`sensor.cost_year_total\` where their calculations are trustworthy.

### Costs, rates and historical accuracy

This blueprint **does not fabricate** a grid consumption meter or substitute consumption figures for a measured home total. It displays the chosen cost sensors as-is. If you have only energy sensors and a price per kWh, configure suitable cost template sensors in Home Assistant before using the cost sections.

**Tariff changes matter:** multiplying historical usage by today's price is not a correct historical bill. For accurate year-on-year costs, ensure the underlying cost calculation preserves settled historical periods (for example, a cost accumulator or archived monthly bill totals). Monthly/yearly cost tiles are snapshots of their sensors, **not a historical monthly cost graph**. Long-term kWh charts are a separate, verified part of this blueprint.

Hue consumption estimated from light output is an **estimate**, not a measured reading.

## Scope

- Independent of Home Assistant's Energy Dashboard grid-source pricing.
- Responsive cards; works in both light and dark themes.
- Does **not** edit entity IDs, recorder configuration, statistics, or automations.
- No guarantee of historical cost aggregation: only the sensor's existing data is displayed.
