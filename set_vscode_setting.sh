jq 'map(select(.id == "workbench.views.extensions.workspaceRecommendations").isHidden |= true)' 'sample_view_setting.json'
