# Energy & Costs — Dwains Dashboard Next

**Status: unreleased. Blueprint version stays 1.0 until its first approved release.**

## Installation

Existing installation: DDNext page **Energie & Kosten**. Elsewhere, import directly from:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

The stock DDNext gallery loads the upstream blueprint repository. This fork has its own catalog entry, but the installed page also stores the complete blueprint.

## Layout

The DDNext page supplies the title and icon. There is no additional hero.

- **Four compact overview tiles:** monthly kWh, monthly €, annual kWh, annual €.
- **Monthly device shares:** an ApexCharts donut based only on current monthly energy sensor states, with a device legend. It uses `data_generator` for each series instead of querying 12 months of recorder long-term statistics. This is a month distribution, **not a historical timeline**.
- **Eight device cards:** a two-column grid of Mushroom Template cards (single column on narrow screens), each with a device icon, monthly consumption and monthly monetary costs.

The recorded historical energy statistics are not deleted or changed; they are simply not loaded on this overview page. Individual sensor history remains accessible through Home Assistant.

## Data sources

Select an energy sensor for each entry in `monthly_consumption`. Add corresponding monetary sensors to `monthly_costs` using the same device name (for example, `Multimedia`). The blueprint matches costs by name and never invents a monetary value where no sensor exists.

The reference Home Assistant installation now contains monthly cost sensors for all eight devices. Four were added alongside tariff correction helpers:

- Kühlgefrierschrank: `sensor.cost_month_kuehlgefrierschrank`
- Waschmaschine: `sensor.cost_month_waschmaschine`
- Siebträger: `sensor.cost_month_siebtraeger`
- Testaufbau: `sensor.cost_month_testaufbau`

Existing cost sensors cover Multimedia, Hue, 3D-Drucker and Schreibtisch-Technik. The newly created monthly cost sensors use the same rate-change correction logic as the existing sensors. The underlying Home Assistant automation also resets and updates their correction helpers.

The main monthly/annual cost tiles use the existing total-cost entities; those totals can include a standing fee and need not equal the sum of device-only costs.

## Dependencies

- Mushroom Template Card
- layout-card
- apexcharts-card

The chart uses ApexCharts `chart_type: donut` with `data_generator`, so the main page avoids recorder requests. The user should check browser rendering after deployment; live screenshot access is not enabled in this installation.

No firmware, equipment, recorder data or energy source preferences are changed by the blueprint.
