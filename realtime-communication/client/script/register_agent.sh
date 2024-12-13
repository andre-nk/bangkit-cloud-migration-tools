#!/bin/bash

# Variables
NSC_HOME="../nsc_envs"
OPERATOR_JWT="../nsc_envs/nats_operator.jwt"
SYS_JWT="../nsc_envs/SYS.jwt"

# Generate random UUIDs for account and user
ACCOUNT_NAME=$(uuidgen)
USER_NAME=$(uuidgen)
CREDS_OUTPUT="../nsc_envs/client.creds"

# Check if required files exist
if [ ! -f "$OPERATOR_JWT" ]; then
    echo "Operator JWT file not found: $OPERATOR_JWT"
    exit 1
fi

if [ ! -f "$SYS_JWT" ]; then
    echo "SYS JWT file not found: $SYS_JWT"
    exit 1
fi

# Step 1: Set NSC_HOME and initialize environment
export NSC_HOME=$NSC_HOME
echo "NSC_HOME set to $NSC_HOME"

# Step 2: Import Operator JWT
echo "Importing operator..."
nsc add operator --url="$OPERATOR_JWT"
nsc edit operator --account-jwt-server-url "nats://nats:4222"
nsc describe operator nats_operator

# Step 3: Import SYS account
echo "Importing SYS account..."
nsc import account --file="$SYS_JWT"

# Step 4: Create new account
echo "Creating account $ACCOUNT_NAME..."
nsc add account $ACCOUNT_NAME

# Step 5: Push the account JWT to the server
echo "Pushing account JWT to the server..."
nsc push --account "$ACCOUNT_NAME"

# Step 6: Create user for the account
echo "Creating user $USER_NAME in account $ACCOUNT_NAME..."
nsc add user --account $ACCOUNT_NAME --name $USER_NAME

# Step 7: Generate user credentials
echo "Generating credentials for $USER_NAME..."
nsc generate creds --account $ACCOUNT_NAME --name $USER_NAME > $CREDS_OUTPUT
echo "Credentials saved to $CREDS_OUTPUT"

# Step 8: Verify NSC setup
echo "Verification of account and user:"
nsc list accounts
nsc list users --account=$ACCOUNT_NAME

echo "NSC setup complete. You can now use the generated credentials at $CREDS_OUTPUT to connect!"