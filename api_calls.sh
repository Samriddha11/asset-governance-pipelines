####    Tagging API Call    ####

#!/bin/bash

# Capture Harness pipeline variables
account_id="<+pipeline.variables.account_id>"
region="<+pipeline.variables.region>"
resource="<+pipeline.variables.resource>"
echo $account_id
echo $region

# ---Tagging Rule API Call---
curl -i -X POST \
  "https://app.harness.io/ccm/api/governance/enqueueAdhocV2?accountIdentifier=PASTE_ACCOUNT_ID_HERE" \
  -H "Content-Type: application/json" \
  -H "x-api-key: PASTE_API_TOKEN_HERE" \
  -d "{
    \"targetAccounts\": [
      \"$account_id\"
    ],
    \"targetRegions\": [
      \"$region\"
    ],
    \"ruleId\": \"PASTE_RULE_ID_HERE\",
    \"isDryRun\": false
  }"



####   Delete Api Call    ####

#!/bin/bash

# Capture Harness pipeline variables
account_id="<+pipeline.variables.account_id>"
region="<+pipeline.variables.region>"
resource="<+pipeline.variables.resource>"
echo $account_id
echo $region

# ---Tagging Rule API Call---
curl -i -X POST \
  "https://app.harness.io/ccm/api/governance/enqueueAdhocV2?accountIdentifier=PASTE_ACCOUNT_ID_HERE" \
  -H "Content-Type: application/json" \
  -H "x-api-key: PASTE_API_TOKEN_HERE" \
  -d "{
    \"targetAccounts\": [
      \"$account_id\"
    ],
    \"targetRegions\": [
      \"$region\"
    ],
    \"ruleId\": \"PASTE_RULE_ID_HERE\",
    \"isDryRun\": false
  }"