# JIRA Utilities

function jira-usage-cmd {
  local cmd=$1;
  >&2 echo "Usage: "${cmd}" <ticket-id>";
}

function jira-usage {
  >&2 echo "Usage: you must set the JIRA_BASE_DOMAIN before using this function";
}

function jira-url {
  local ticket=$(echo -n "$1" | awk '{ print toupper($0) }')
  local cmd=$2;
  
  if [ -z "${cmd}" ]; then
    cmd="jiraurl";
  fi
  
  if [ -z "$ticket" ]; then
    jira-usage-cmd "${cmd}";
    return 1;
  fi

  if [ -z "${JIRA_BASE_DOMAIN}" ]; then
    jira-usage;
    return 1;
  fi

  local url="https://${JIRA_BASE_DOMAIN}/browse/${ticket}";
  
  echo "${url}" | pbcopy;
  echo "${url}";
}

function jira {
  local ticket=$(echo -n "$1" | awk '{ print toupper($0) }')
  
  if [ -z "$ticket" ]; then
    jira-usage-cmd jira;
    return 1;
  fi

  if [ -z "${JIRA_BASE_DOMAIN}" ]; then
    jira-usage;
    return 1;
  fi
  
  local url=$(jira-url "${ticket}" | tr -d '\n');
  open "${url}";
}
