# OTP Generator Functions

function otp {
  local key_file=$1
  
  if [ -z "$key_file" ]; then
    echo "Usage: otp <key_file.txt>"
    return 1
  fi
  
  if [ ! -f "$key_file" ]; then
    echo "Key file not found"
    return 1
  fi
  
  local key
  key=$(cat "$key_file")
  
  # Generate TOTP code
  otpauth_url="otpauth://totp/example?secret=$key"
  open "$otpauth_url"
}
