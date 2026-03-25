#!/usr/bin/env bash

PROFILE="${AWS_PROFILE:-default}"
REGION="${AWS_REGION:-${AWS_DEFAULT_REGION:-none}}"

# Try to get account ID (requires AWS CLI and valid credentials)
ACCOUNT_ID=""
if command -v aws &> /dev/null; then
    ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text 2>/dev/null || echo "")
fi

if [[ -n "$ACCOUNT_ID" ]]; then
    echo "$PROFILE @ $REGION (Account: $ACCOUNT_ID)"
else
    echo "$PROFILE @ $REGION"
fi
