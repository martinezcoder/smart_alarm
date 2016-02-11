json.id endpoint.id
json.name endpoint.name
json.status endpoint.status
json.expires_at Time.at(endpoint.expires_at).strftime("%Y-%m-%d %I:%M%p")
json.sent_alert endpoint.sent_alert
json.retries endpoint.retries
