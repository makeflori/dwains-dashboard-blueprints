# Energy & Costs — DDNext

**Status: unreleased, version 1.0.** Do not bump until the initial release is approved.

The page is installed as **Energie & Kosten** in Dwains Dashboard Next. Its live DDNext strategy contains both an embedded blueprint source and a resolved card configuration. Both need to be updated together.

Blueprint URL:
https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Layout

1. **Overview:** Four theme-aware KPIs (month kWh, month EUR, year kWh, year EUR). The overall month sensor is used when configured; otherwise the sum of selected device sensors is used.
2. **One shared analysis row:** A native monthly `statistics-graph` on the left and a significantly larger consumption donut with a complete legend on the right. The responsive `layout-card` stacks them on narrow displays.
3. **Monthly history:** Eight configured cumulative energy sensors, one for every listed device, over the last 180 days. `statistics-graph` uses `stat_types: [change]` and `period: month`; these represent recorder's historical changes in kWh and **not** the currently calculated monthly costs. Missing early-month statistics are left missing.
4. **Device groups:** Kitchen, Office, Living Room, Bathroom and cross-room lighting, retaining the original grouping. Each tile now shows the monthly kWh prominently and the corresponding EUR cost underneath. Percentage text and redundant share bars have been removed.
5. **Consumption shares:** The donut shows percentage shares of **recorded devices**, not unmetered household electricity. All available positive-consumption devices are listed, and zero/unavailable values do not generate misleading positive slices.
6. **Theme and responsiveness:** All card surfaces, borders and labels follow Home Assistant theme variables; no forced black backgrounds.

The large Sankey was intentionally removed: it mostly repeated information now provided by the donut and device cards.

## Historical sources and quality caveats

The following cumulative sensors are configured in the installed DDNext page:

| Device | Cumulative sensor |
| --- | --- |
| Multimedia | `sensor.energy_total_multimedia_calculated` |
| Kühlgefrierschrank | `sensor.verbrauch_gesamt_kuehlgefrierschrank` |
| Hue-Beleuchtung | `sensor.energy_total_hue_estimated` |
| 3D-Drucker | `sensor.verbrauch_gesamt_3d_drucker_fortgefuhrt` |
| Siebträger | `sensor.verbrauch_gesamt_siebtraeger` |
| Schreibtisch-Technik | `sensor.verbrauch_gesamt_schreibtisch_fortgefuhrt` |
| Waschmaschine | `sensor.verbrauch_gesamt_waschmaschine` |
| Testaufbau | `sensor.verbrauch_gesamt_testaufbau` |

**Data caveat, checked 2026-11-22:** All eight expose recorder long-term `change` statistics, but coverage differs. Negative monthly changes occur in older data for the refrigerator, washing machine, and test setup, likely caused by meter resets or corrections. The 3D printer and desk sources have only a short history. This release does **not** fabricate the missing historical months or rewrite the recorder. Native statistics graph behaviour with these historical anomalies needs checking on the actual DDNext frontend.

The entire dashboard remains a comparison of the eight metered/estimated devices, **not a complete building electricity balance**. Costs are not extrapolated backwards using today's tariff.

## Dependencies

- [button-card](https://github.com/custom-cards/button-card): dynamic KPI tiles, donut and device cards
- [layout-card](https://github.com/thomasloven/lovelace-layout-card): responsive analysis row and device groups
- [card-mod](https://github.com/thomasloven/lovelace-card-mod): styling the native Home Assistant statistics card
- Home Assistant native `statistics-graph`: historical monthly changes

## Verification

After the update, the GitHub YAML and the installed DDNext page's embedded blueprint were confirmed identical. The generated configuration carries all eight historical sensor IDs and the original eight current-consumption and eight cost sensor assignments. DDNext saved the modified strategy successfully.

Browser screenshot verification is unavailable via the current HA MCP connection (dashboard screenshot mode disabled), so exact appearance and the native history rendering remain to be checked in the real browser.
