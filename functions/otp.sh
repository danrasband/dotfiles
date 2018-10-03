#!/bin/bash
#
# Generate one time passwords based on a QR code

otp() {
  local qrcode_path=$1;
  local output=$(zbarimg $qrcode_path);
  local secret=$(sed -E "s/.*secret=([^&]+).*/\\1/" <<< $output)
  local password=$(oathtool --totp -b $secret);
  echo -n $password | pbcopy
  echo "One time password copied to clipboard."
}
