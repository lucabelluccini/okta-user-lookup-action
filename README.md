# Okta user lookup action

Lookup the Okta profile info providing the email.

The API used is the [`Okta list-users`](https://developer.okta.com/docs/reference/api/users/#list-users).

## Inputs

## `lookup-email`

**Required** The name of the user to lookup in Okta.

## `okta-token`

**Required** The Okta token (`SSWS`) to access the API.

## `okta-endpoint`

**Required** The Okta endpoint (e.g. `yourcompany.okta.com`) to access the API.

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
