# Journal Functions

function journalinit {
  local journal_name=${1:-"journal"}
  local journal_path=~/.journals/"$journal_name"
  
  mkdir -p "$journal_path"
  echo "Journal '$journal_name' initialized at $journal_path"
  
  cat > "$journal_path/notes.txt" << EOF
# Journal: $journal_name
Created: $(date +%Y-%m-%d)

EOF
}

function journalnew {
  local journal_name=${1:-"journal"}
  local journal_path=~/.journals/"$journal_name"
  local note_file="$journal_path/notes.txt"
  
  if [ ! -f "$note_file" ]; then
    echo "Journal not found. Run journalinit first."
    return 1
  fi
  
  local note_content
  read -p "Enter note: " note_content
  
  echo "$note_content" >> "$note_file"
  echo "Note added to journal"
}

function journalopen {
  local journal_name=${1:-"journal"}
  local journal_path=~/.journals/"$journal_name"
  
  if [ ! -d "$journal_path" ]; then
    echo "Journal not found"
    return 1
  fi
  
  cat "$journal_path/notes.txt"
}

function journalrm {
  local journal_name=$1
  
  if [ -z "$journal_name" ]; then
    echo "Usage: journalrm <journal_name>"
    return 1
  fi
  
  local journal_path=~/.journals/"$journal_name"
  
  if [ -d "$journal_path" ]; then
    rm -rf "$journal_path"
    echo "Journal '$journal_name' removed"
  else
    echo "Journal not found"
  fi
}

function journalls {
  echo "Available journals:"
  ls -1 ~/.journals/ 2>/dev/null
}
