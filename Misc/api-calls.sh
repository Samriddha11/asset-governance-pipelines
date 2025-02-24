# ---Tagging Rule API Call---
curl -i -X POST \
  'https://app.harness.io/ccm/api/governance/enqueueAdhocV2?accountIdentifier=SxuV0ChbRqWGSYClFlMQMQ' \
  -H 'Content-Type: application/json' \
  -H 'x-api-key: pat.SxuV0ChbRqWGSYClFlMQMQ.67a9d38e1b3d3e58fa1888a8.L6efUKK4SiiRvb6ZRxh4' \
  -d '{
    "targetAccounts": [
      "759984737373"
    ],
    "targetRegions": [
      "us-east-1"
    ],
    "ruleId": "67b1ab31d6c23b6b3d528fdf",
    "isDryRun": false
  }'



# ---Delete Rule API Call---

  curl -i -X POST \
  'https://app.harness.io/ccm/api/governance/enqueueAdhocV2?accountIdentifier=SxuV0ChbRqWGSYClFlMQMQ' \
  -H 'Content-Type: application/json' \
  -H 'x-api-key: pat.SxuV0ChbRqWGSYClFlMQMQ.67a9d38e1b3d3e58fa1888a8.L6efUKK4SiiRvb6ZRxh4' \
  -d '{
    "targetAccounts": [
      "759984737373"
    ],
    "targetRegions": [
      "us-east-1"
    ],
    "ruleId": "67b1ae31d6c23b6b3d528fe4",
    "isDryRun": false
  }'

