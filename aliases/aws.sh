# AWS Profile Aliases

# AWS SSO Login Aliases
alias iot-dev="aws sso login --profile iot-dev"
alias iot-stg="aws sso login --profile iot-stage"
alias iot-stage="aws sso login --profile iot-stage"
alias iot-prod="aws sso login --profile iot-prod"
alias datahub-prod="aws sso login --profile datahub-prod"

# AWS CLI Profile Shortcuts
alias aws-dev="aws --profile iot-dev"
alias aws-stage="aws --profile iot-stage"
alias aws-prod="aws --profile iot-prod"
