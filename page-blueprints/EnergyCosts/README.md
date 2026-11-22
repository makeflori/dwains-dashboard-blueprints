# Energy & Costs — Dwains Dashboard Next

**Unreleased version 1.0.** Do not increase the version until the first release is approved.

The page is already installed in Dwains Dashboard Next as **Energie & Kosten**.

## Blueprint

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

The stock DDNext gallery loads upstream blueprints, so use the URL when importing into a different installation.

## Compact layout

The existing DDNext page header supplies the title and icon. No duplicate hero is rendered.

- **Four compact KPIs** arranged in one row on desktop and two columns on mobile: monthly consumption, monthly costs, yearly consumption and yearly costs.
- **Energy history** displays 12 months of cumulative energy consumption as a stacked bar chart with a visible legend and German month/year labels. Negative corrections in historical statistics are omitted as missing data points.
- **Eight compact device tiles**, four columns on wider screens and fewer on narrower screens, each showing a device icon, device name, monthly kWh and current monthly euro cost when a cost sensor exists. A dash means no device cost sensor exists; it is not a claim of zero cost.

The cards use the **Mushroom Template Card** for typography and semantic icon styling, not manually generated markdown tables. The graph uses **ApexCharts**, and placement uses **layout-card**. All three are installed in the target Home Assistant.

## Inputs

- `total_energy_month`, `total_cost_month`, `total_energy_year`, `total_cost_year`: headline sensor entities
- `monthly_consumption`: one or more monthly energy sensors with names and icons
- `monthly_costs`: monthly monetary sensors; match device names to consumption entries to show costs
- `cumulative_meters`: lifetime energy meter sensors with long-term statistics

The blueprint does not modify meter data, energy settings, tariff history or Home Assistant automations. Total cost sensors may include fixed fees that are not represented among the device cost tiles.

## Checks

Before installation, all 12 Mushroom secondary templates were rendered successfully against the current Home Assistant state. The stored DDNext page and GitHub YAML were verified to have identical blueprint source. Actual browser rendering still needs visual confirmation after refresh.
