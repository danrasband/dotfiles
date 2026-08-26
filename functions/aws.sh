# AWS SSO Login Functions

function aws-login {
  profile="$1";
  if [ -z "$profile" ]; then
    echo "Profile is required as first argument.";
  fi

  aws sso login --profile "$profile";

  if $(which aws-sso-creds-helper 2>&1 > /dev/null); then
    aws-sso-creds-helper --debug -p "$profile";
  fi
}

function aws-login-all-iot {
  for profile in dev stage prod; do
    aws-login "$profile"
  done
}
