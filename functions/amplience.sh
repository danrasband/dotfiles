# Amplience Helpers

function amplience-edit {
  contentId=$1;
  if [ -z "${contentId}" ]; then
    >&2 echo "Usage: amplience-edit <content-id> [amplience-hub-name]";
    return 1;
  fi

  hubname=$2;
  if [ -z "${hubname}" ]; then
    if [ -z "${AMPLIENCE_HUB_NAME}" ]; then
      >&2 echo "Usage: amplience <content-id> <hub-name> or set AMPLIENCE_HUB_NAME variable.";
      return 1;
    fi

    hubname="${AMPLIENCE_HUB_NAME}";
  fi
  
  local url="https://app.amplience.net/content/#\!/${hubname}/authoring/content-item/edit/${contentId}";
  echo -n "${url}" | pbcopy;
  open "${url}";
}

function amplience-cdn {
  contentId=$1;
  if [ -z "${contentId}" ]; then
    >&2 echo "Usage: amplience-cdn <content-id> [amplience-hub-name]";
    return 1;
  fi

  hubname=$2;
  if [ -z "${hubname}" ]; then
    if [ -z "${AMPLIENCE_HUB_NAME}" ]; then
      >&2 echo "Usage: amplience-cdn <content-id> <hub-name> or set AMPLIENCE_HUB_NAME variable.";
      return 1;
    fi

    hubname="${AMPLIENCE_HUB_NAME}";
  fi

  local url="https://${hubname}.cdn.content.amplience.net/content/id/${contentId}";
  echo -n "${url}" | pbcopy;
  open "${url}";
}
