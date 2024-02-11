# Okta user lookup action

Lookup the Okta profile info providing the email

## Inputs

## `lookup-email`

**Required** The name of the person to greet.

## `okta-token`

**Required** The Okta token to access the API.

## `okta-endpoint`

**Required** The Okta endpoint to access the API.

## Outputs

## `okta-profile-info`

The profile information as JSON object.

## Example usage

```
uses: actions/okta-user-lookup-action
with:
  lookup-email: ...
  okta-token: ...
  okta-endpoint: ...
```
