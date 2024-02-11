#!/bin/sh

echo "Lookup email input parameter: $LOOKUP_EMAIL"
echo "Okta endpoint input parameter: $OKTA_ENDPOINT"

OUT_FILE=okta-response-output.json
RETRIES=3
MAX_TIME=20
http_response_code=$(curl -s \
  --retry $RETRIES \
  --max-time $MAX_TIME \
  -H "Authorization: SSWS $OKTA_TOKEN" \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json; okta-response=omitCredentials,omitCredentialsLinks,omitTransitioningToStatus' \
  --data-urlencode "search=profile.email eq $LOOKUP_EMAIL and status eq ACTIVE" \
  "https://$OKTA_ENDPOINT/api/v1/users" \
  -o $OUT_FILE \
  -w "%{http_code}" \
)

echo "HTTP response code from curl is $http_response_code"
if [ $http_response_code -eq 200 ]; then
  # check anyway if we the output file
  if [ ! -f "$OUT_FILE" ]; then
      echo "::error::No response generated but request was 200"
      exit 1
  fi
  # Check if the file contains exactly one item in the array and that item has the property "profile"
  has_one_profile=$(jq '[length == 1] and .[0] | has("profile")' "$OUT_FILE")
  if [ "$has_one_profile" = "true" ]; then
      profile=$(jq '.[0].profile' "$OUT_FILE")
      echo "okta-profile-info=$profile" >> $GITHUB_OUTPUT
      exit 0
  else
      echo "::error::Expected 1 profile only and/or it doesn't contain the profile info"
      exit 2
  fi
else # 000 if any other kind of error
  echo "::error::curl unsuccesful or non-200 HTTP response code from Okta ($http_response_code)"
  exit 3
fi
