# Energy & Costs — DDNext

**Status: unreleased, version 1.0.** The initial release/version bump is still pending approval.

This page is informed by [Madelena's Home Assistant Energy View](https://github.com/Madelena/hass-config-public/blob/main/ui/views/energy.yaml). It adapts the denser, more data-focused layout to available energy and cost sensors. It is **not** a grid/source/circuit electricity Sankey: those quantities are not provided by this installation.

## Install and source

The page is installed as **Energie & Kosten** in the target Dwains Dashboard Next dashboard. Reusable source:

https://raw.githubusercontent.com/makeflori/dwains-dashboard-blueprints/main/page-blueprints/EnergyCosts/blueprint.yaml

Updating the GitHub YAML alone does **not** update an existing page. DDNext stores both the blueprint YAML and the resolved card configuration in its dashboard strategy's `pages`. Both were updated together for the installed page.

## Layout

1. **Recorded device flow (month-to-date):** compact, filled SVG ribbons for measured/estimated device consumption → configured groups → devices. Group and device positions are sorted by month-to-date kWh. Widths represent measured quantities; the diagram is not a simulation of physical power flow. The phone layout switches to ranked expandable group bars with device details. Background, borders and text use Home Assistant theme tokens; category colors are accents.
2. **Overview:** four numerical KPIs for current month's overall kWh and EUR plus annual kWh and EUR. The total-month sensor is optional for new installations; if unavailable, the current sum of listed devices is shown. The accompanying donut displays **device shares of the recorded device total** once, in kWh; no duplicate price-share chart is drawn.
3. **History:** one native `statistics-graph` showing monthly `change` for configured *cumulative* energy meters over the last 180 days. This is a selected-device comparison, not a complete household history. It requires recorder long-term statistics and may load after the instant cards.
4. **Devices:** grouped device cards show month-to-date kWh, EUR cost, and a bar labeled with that device's percentage of the **recorded devices**. Device cards open the underlying consumption entity on tap. No fabricated history sparklines or live-W values are shown.
5. **Performance:** the Sankey and overview compute from current HA states without recorder requests. Device cards subscribe only to the configured consumption and cost sensors; the overview likewise listens to its actual dependencies. Only the history graph queries long-term recorder data.

The optional `total_energy_month` input refers to the whole monthly energy counter, so its figure can differ slightly from the sum of the eight selected devices visualized in the flow and donut.

## Existing HA bindings

The installed page preserves its 8 device consumption entities, 8 device cost entities, 5 configured groups and 3 cumulative historical source meters (Multimedia, Hue, Siebträger). All existing entity IDs and associations are retained.

The historical comparison should have data: in Home Assistant, the three configured source sensors returned monthly `change` statistics for the preceding six months on 2026-11-22. The former graph occupied excessive space in the actual dashboard screenshot; this revision removes the nested layout wrappers and shortens the window.

## Dependencies

- [button-card](https://github.com/custom-cards/button-card): dynamic flow, overview and device layouts
- [layout-card](https://github.com/thomasloven/lovelace-layout-card): responsive grouping
- Home Assistant native `statistics-graph`: historical monthly aggregates

## Validation and limitations

The installed page's stored source was read before editing. After the rewrite, its complete source was read back and confirmed byte-for-byte identical to the GitHub blueprint. The resolved card configuration includes the new flow, overview, historical graph and eight device cards, and the same entity bindings were preserved.

**Browser rendering has not yet been visually verified.** In particular, the native statistics graph should be inspected in the real DDNext frontend after it finishes loading; availability of long-term statistics alone does not guarantee a correct frontend render.

The page uses light/dark theme variables, no hard-coded black card backgrounds, and no historical cost series derived from applying today's rate to old electricity consumption.
