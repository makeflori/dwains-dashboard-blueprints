# Energy & Costs — Dwains Dashboard Next

**Unreleased blueprint, version 1.0.** This page is intended to be configured and reviewed before the first release.

## Install

The existing Dwains Dashboard Next installation already has the page under **Energie & Kosten**. The dashboard page stores the blueprint YAML and a resolved card configuration.

For another installation, import:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

The stock DDNext blueprint gallery reads the upstream repository, not this fork. Import the URL directly unless the gallery source is changed.

Required cards: [button-card](https://github.com/custom-cards/button-card), [layout-card](https://github.com/thomasloven/lovelace-layout-card) and [apexcharts-card](https://github.com/RomRider/apexcharts-card).

## Design and structure

The dashboard's own page title and icon provide the navigation header. **No hero or duplicate page title** is rendered.

### Monat

- Two side-by-side KPIs: device electricity consumption and costs for the current month.
- One device comparison with **usage and cost in adjacent columns**.
- Devices are sorted by their current consumption and have a small relative-consumption bar.
- Device-specific icons appear **to the left of names**.
- A dash in the costs column means no cost sensor was selected for this device; it is not a zero-cost claim.

Costs are looked up by matching the configured device names in the separate energy and cost entity lists. Keep names consistent when editing those inputs. A sensor is never invented for an unmeasured device.

### Jahr

- Two side-by-side KPIs for yearly consumption and costs.
- Twelve-month consumption graph using the selected cumulative kWh sensors with Home Assistant long-term statistics, presented with month/year labels such as **Jan 26**.
- Historical negative meter corrections are omitted as missing data points (not shown as negative energy and not replaced with 0).
- Annual device cost comparison for the selected yearly cost sensors.

The installed configuration includes eight device energy meters, four monthly device cost sensors and three yearly device cost sensors. The numbers are read directly from Home Assistant. Monthly and annual total cost entities can include standing charges; device costs are not automatically equal to those totals.

## Data integrity

This is a presentation blueprint, not a billing ledger. It does **not** modify the sensors, recorder, price history, or Home Assistant Energy Dashboard configuration. A correct historical monetary view requires the cost sensors themselves to preserve past electricity tariffs; this blueprint does not retroactively multiply past energy use by today's tariff.

The Apple Human Interface Guidelines informed the layout choices: hierarchy, consistent spacing, readable values and restrained use of visual embellishment. This is not a claim of native Apple UI certification.

## Versioning

Keep `blueprint.version: "1.0"` during the current unpublished design iterations. Only advance the version when a first release is explicitly approved.
