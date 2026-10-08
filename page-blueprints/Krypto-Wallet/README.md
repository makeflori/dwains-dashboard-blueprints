# Krypto-Wallet

Total portfolio value plus, for each of the seven currently displayed cryptocurrencies, a value sensor, EUR price sensor, and quantity/volume sensor. The displayed assets and their order are fixed in this version.

## Import

In **Dwains Dashboard Next**, open the Pages section, add a **Blueprint page**, choose **URL**, and paste:

https://github.com/makeflori/dwains-dashboard-blueprints/blob/main/page-blueprints/Krypto-Wallet/blueprint.yaml

Select the corresponding local Home Assistant entities in the configuration form. No personal entity IDs are preselected. Ensure the required custom cards reported by the import dialog are installed.

The file is a **Dwains Dashboard page blueprint** (\`blueprint.type: page\`), not an automation blueprint for Home Assistant's automation import dialog.

The original dashboard page was not changed by this publication. These blueprints have been structurally parameterized; installation and runtime rendering should be verified on a second Home Assistant setup before treating them as fully portable.
