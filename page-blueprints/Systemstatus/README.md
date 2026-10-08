# System Monitor · v1.0.0

Select system metric, backup, memory and update entities. Inputs are suggested only when a single known matching entity exists; otherwise choose manually. Some installation-specific filters still need review.

Import in Dwains Dashboard Next → Pages → Add Blueprint → URL:

https://github.com/makeflori/dwains-dashboard-blueprints/blob/main/page-blueprints/Systemstatus/blueprint.yaml

The configuration dialog requires a Dwains Dashboard Next version containing the **repeatable blueprint input** updates in [PR #136](https://github.com/makeflori/dwains-dashboard-next/pull/136). The published blueprint does not require modifying your existing pages.

Home Assistant language `de` uses German text; all other languages use English fallback. Suggested entity names remain editable. Any detected entity should be verified before saving.

**Note:** Source entities and their units/date attributes must be compatible with the page's presentation. Runtime installation tests on a second HA environment are still required.
