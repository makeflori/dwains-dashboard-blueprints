# Crypto Wallet · v1.0.0

Add or remove any number of cryptocurrencies. Each item has a required value sensor, optional price and holdings sensors, editable friendly name and optional icon (defaults to mdi:currency-btc). The portfolio total uses its own sensor.

Import in Dwains Dashboard Next → Pages → Add Blueprint → URL:

https://github.com/makeflori/dwains-dashboard-blueprints/blob/main/page-blueprints/Krypto-Wallet/blueprint.yaml

The configuration dialog requires a Dwains Dashboard Next version containing the **repeatable blueprint input** updates in [PR #136](https://github.com/makeflori/dwains-dashboard-next/pull/136). The published blueprint does not require modifying your existing pages.

Home Assistant language `de` uses German text; all other languages use English fallback. Suggested entity names remain editable. Any detected entity should be verified before saving.

**Note:** Source entities and their units/date attributes must be compatible with the page's presentation. Runtime installation tests on a second HA environment are still required.
