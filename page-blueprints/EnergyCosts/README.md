# Energy & Costs — Dwains Dashboard Next

**Status:** Unreleased; blueprint version 1.0. No release bump yet.

The installed page **Energie & Kosten** is backed by DDNext's storage dashboard strategy. To update an existing installation, both its embedded blueprint source and resolved cards must be replaced; changing only the GitHub file does not automatically refresh an installed page.

Source: https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

## Design

### Consistent KPI grid

Four equal cards, with all titles *inside* the respective card: **Verbrauch · Monat**, **Verbrauch · Jahr**, **Kosten · Monat** and **Kosten · Jahr**. They use the same font hierarchy, rounding and spacing. Both consumption cards share one category accent; both cost cards share another. The KPI container has matching horizontal inset so its outer edges align with the chart row in DDNext.

### Matching comparison cards

- **Verbrauch · Monatsverlauf**, at left: ApexCharts Card with a compact plot, all eight configured historical energy meters and five devices enabled initially. Remaining series are still visible in the legend and can be selected. Older negative meter corrections are excluded rather than relabelled. A compact, matching title is rendered via the Apex card's `card_mod` stylesheet, with its own native header disabled.
- **Kostenverteilung · aktueller Monat**, at right: an enlarged doughnut/donut, showing monthly **EUR** cost allocations and a table of devices, percentages and amounts. The middle of the diagram contains only a number; underneath is **€ / Monat**. The explicit standing-charge helper is used to show **Grundpreis**, avoiding the former ambiguous *Nicht zugeordnet* entry. The previous explanatory footer has been removed.
- Both cards share the same 12px corner radius, theme-aware background/border and approximately 348px minimum height. Unlike the preceding 410px minimum, the sizing is reduced to avoid large empty areas. Responsive grid layout stacks them on narrower screens.

### Device cards

The original five room/group headings are retained: Küche, Büro, Wohnzimmer, Bad and Raumübergreifend. On wide desktop layouts they occupy **five columns**, with adaptive three/two/one-column fallbacks. Each device card shows its current-month kWh and absolute EUR costs and the same stable device colour as the historical chart and cost distribution.

## Monthly standing charge — verified source

The additional optional blueprint input **`base_fee_month`** is mapped on the installed page to **`input_number.grundpreis_monat_strom`**. On 2026-11-22 its value was **13.90 EUR/month**. The existing total-month cost sensor is defined in `templates.yaml` as monthly energy use × electricity working price, **plus the actual standing charge and any explicit historic cost corrections**. Both current monthly correction inputs were zero when checked. This establishes that the former large residual was the current month's standing charge, rather than some unknown electricity consumer. Neither Home Assistant's tariff calculations nor sensor definitions were edited.

The cost diagram displays the selected device cost sensor values plus the actual standing charge. If a configured total cost exceeds that sum by more than small rounding tolerance, the remainder is shown as **Weitere Kosten**, not mislabelled as the standing charge. If no standing-charge entity is set for another installation, the diagram shows only the available device-cost allocation.

## Chart limitations

ApexCharts Card's `experimental.hidden_by_default` feature is used for the three smaller historical series. Its limitations apply, including potentially imperfect automatic scaling. The five active default series are currently Multimedia, Kühlgefrierschrank, Hue-Beleuchtung, 3D-Drucker and Siebträger, based on the latest available ranking at configuration time. This selection is **not recalculated automatically whenever monthly rankings change**. The graph uses native historical recorder statistics and can load more slowly than current-value cards.

## Dependencies and verification

Requires `button-card`, `layout-card`, `apexcharts-card`, and `card-mod` for the historical chart's matching title and frame.

The entire installed DDNext blueprint source was compared byte-for-byte with GitHub and found identical. Both inline JavaScript components for KPIs and cost allocation were compiled and rendered using live HA numeric state values without errors. All eight current-month consumption sensors, eight cost sensors, and eight historical meter references were preserved.

**The actual browser appearance remains to be checked:** screenshot mode is disabled on the available Home Assistant connection. In particular, the custom ApexCharts title and equal-height grid behavior cannot be proven from stored YAML alone.
