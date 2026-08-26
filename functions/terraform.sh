function tf-env-check() {
  if [ -z "$1" ]; then
    >&2 echo "Usage: must set stage: dev, stg, or prod";
    return 1;
  fi
}

# Initialize a terraform configuration.
function tf-init() {
  if ! tf-env-check "$1"; then return 1; fi
  
  local profile;
  case "$1" in
    "dev")  tf_env_name="dev"; profile="iot-dev" ;;
    "stg")  tf_env_name="stg"; profile="iot-stage" ;;
    "prod") tf_env_name="prd"; profile="iot-prod" ;;
  esac

  AWS_PROFILE="${profile}" terraform init \
    -backend-config="./init-tfvars/${tf_env_name}.tfvars" \
    -reconfigure  
}

# Initialize and run a terraform plan.
function tf-plan() {
  local profile;
  case "$1" in
    "dev")  tf_env_name="dev"; profile="iot-dev" ;;
    "stg")  tf_env_name="stg"; profile="iot-stage" ;;
    "prod") tf_env_name="prd"; profile="iot-prod" ;;
  esac

  # Ensure repo is initialized for proper environment first.
  ! tf-init "$1" && return 1;

  AWS_PROFILE="${profile}" terraform plan \
    -var-file="./apply-tfvars/${tf_env_name}.tfvars" \
    -out tfplan
}

function tf-apply() {
  if ! tf-env-check "$1"; then return 1; fi
  
  local profile;
  case "$1" in
    "dev")  profile="iot-dev" ;;
    "stg")  profile="iot-stage" ;;
    "prod") profile="iot-prod" ;;
  esac
  
  AWS_PROFILE="${profile}" terraform apply tfplan
}

function tf-plan-apply() {
  if ! tf-env-check "$1"; then return 1; fi
  
  ! tf-plan "$1" && return 1;
  tf-apply "$1";
}
