# Replace Sensor Card

Replaces sensor cards with a large reading and a history graph by makeflori.

A compact sensor card inspired by the classic Dwains sensor tile and styled to match Dashboard Next.

- Sensor name at the top left; sensor icon in a tinted container at the right.
- Large value with the original unit, formatted by Home Assistant.
- Native line graph along the bottom, with a configurable history window (24 hours by default).
- 10 px corners, a subtle shadow and Home Assistant theme colours.
- Automatic DD Next accents: temperature purple, humidity blue, power/energy amber, other sensors muted blue.
- More-info on tap; no fabricated zero for missing or unavailable values.

## Requirements

Install and load [card-mod](https://github.com/thomasloven/lovelace-card-mod). No mini-graph-card is required. The graph uses Home Assistant's sensor card and recorded history.

Use numeric `sensor.*` entities. Text sensors and binary sensors need a different card. Recorder must retain the selected entity's history. The graph is a compact trend overview with automatic scaling.

## Usage

- This file is a `replace-card` blueprint. DD Next supplies the entity and its friendly name through `$replace_with_input_entity$` and `$replace_with_input_name$`. It can be assigned to individual sensors or sensor types through the replacement manager once it is available in that manager's gallery.

The replacement blueprint changes only assigned sensor cards; it is not automatically applied to Home Assistant.

## Inputs

`hours_to_show`: positive number, normally 24.
`accent_color`: `auto` or a valid CSS colour. Automatic colours mirror the Dashboard Next palette at creation time; they are not a live import of its source code.

DD Next's current default gallery points upstream. This blueprint in the fork will not appear in that default gallery until the gallery source is changed or the blueprint is accepted upstream.

## Validation

Blueprint parsing, placeholder resolution, numeric input handling and registry generation are checked. Visual layout still needs to be verified in the running Home Assistant frontend, especially after frontend or card-mod updates.
