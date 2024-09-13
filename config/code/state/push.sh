hidden_views=$(cat hidden_views)

while read -r key view; do
  echo KEY $key
  echo VIEW $view
done <<< "$hidden_views"

hidden_status_items=$(cat hidden_status_items)

while read -r item; do
  echo ITEM $item
done <<< "$hidden_status_items"
