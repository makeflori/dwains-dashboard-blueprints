# Energy & Costs — Dwains Dashboard Next

**Blueprint version: 1.0 (unreleased).** Installed page: **Energie & Kosten**.

Source: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Layout and data sources

- Four matching current-value KPI cards: Verbrauch · Monat, Verbrauch · Jahr, Kosten · Monat, Kosten · Jahr. Each card forms a single visual group with an icon immediately beside its label; the numerical value is right-aligned.
- **Verbrauch · Monatsverlauf:** Native ApexCharts Card with eight cumulative energy sensors, six months, long-term recorder statistics (`change`, `month`), and a dynamic y-axis with a subdued kWh title. The original custom category axis was removed after it displayed raw Unix timestamps. The new axis uses ApexCharts' native **datetime** mode and `MMM yy` labels. The five selected top consumers remain active initially, and the three others can be toggled by the legend; no kWh values are printed inside legend labels.
- **Kostenverteilung · aktueller Monat:** Native ApexCharts **donut** (`chart_type: donut`) with eight monthly cost sensors and the verified monthly electricity standing-charge helper. This is an **interactive ApexCharts** element, not an HTML/SVG fragment embedded in a button-card. Native slice hover, tooltip and legend support are enabled. Values refer exclusively to euros; current kWh is deliberately not mixed into the monetary distribution chart.
- The two comparison cards use the same component, header setting, card border, rounding, themed background and minimum card height. Their inner chart types have different appropriate visualizations.
- The bottom room/device section has been removed as redundant. The mobile bottom navigation spacer remains.

## User-configurable inputs

- `total_energy_month`, `total_energy_year`, `total_cost_month`, `total_cost_year`: KPI sensor IDs.
- `monthly_consumption`: current-month consumption sensors used for the KPI's fallback total when the overall sensor is absent.
- `historical_consumption_meters`: cumulative kWh meters with recorder statistics; their names establish chart series and their `hidden_by_default` flags establish the initial selection.
- `monthly_costs`: eight device-cost sensors feeding the donut.
- `base_fee_month`: electricity standing-charge helper, e.g. `input_number.grundpreis_monat_strom`. The cost donut needs a valid configured standing-charge entity in the installed setup; it is not inferred as the difference between totals.

The installed page preserves its eight current-month consumption and cost sensors, eight cumulative historical meters, and base fee helper.

## Data-source discrepancy still unresolved

On 2026-11-22, the Multimedia cumulative meter `sensor.energy_total_multimedia_calculated` reported approximately **12.73 kWh** in the current monthly long-term statistics; the separate current-month sensor `sensor.verbrauch_monat_multimedia_kalibriert` reported approximately **11.65 kWh**. These values come from different calculations. Neither calculation has been edited; correcting the difference requires examining their respective definitions and history. The new native chart no longer displays a current-state numerical value inside the legend, which avoids juxtaposing these conflicting values.

The verified standing charge is `input_number.grundpreis_monat_strom` = **13.90 EUR/month**, and the monthly cost aggregate includes this charge by the definition in `templates.yaml`.

## Requirements

- [button-card](https://github.com/custom-cards/button-card): four current-value KPI cards
- [layout-card](https://github.com/thomasloven/lovelace-layout-card): responsive dashboard columns
- [apexcharts-card](https://github.com/RomRider/apexcharts-card): historical column chart **and** interactive donut
- [card-mod](https://github.com/thomasloven/lovelace-card-mod): matched card styles

## Validation

The installed DDNext page stores the embedded blueprint source and the already-resolved card configuration. Both were updated, then checked against the GitHub source. The card structure is four KPI tiles, two native ApexCharts instances, and the mobile spacer.

The actual rendered frontend has **not** been visually checked because the screenshot capability is unavailable through the connected Home Assistant tool. In particular, native datetime tick placement and donut hover behavior still require browser verification.
