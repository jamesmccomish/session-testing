# Testing Session Keys on Base Smart Wallet
Attempting to setup [session keys on the Base Smart Wallet](https://www.smartwallet.dev/guides/session-keys#session-keys) using [smart-wallet-permissions](https://github.com/coinbase/smart-wallet-permissions).

# Goal
Enable an account to setup a session to give an app an allowance of 3 clicks on a counter.

# Structure
## Contracts
- A simple counter extended with PermissionCallable: [PermissionedCounter](/contracts/src/PermissionedCounter.sol)
- Allowance logic to track spending of clicks: [CounterAllowance](/contracts/src/permissions/logic/CounterAllowance.sol)
- An implementation of IPermissionContract to consume the allowance: [PermissionCallableCounterAllowance](/contracts/src/permissions/callable/PermissionCallableCounterAllowance.sol)

## Frontend
- A simple frontend to test the flow: [frontend](/frontend/src/components/App.tsx)
- A button to grant permissions: [GrantPermissions](/frontend/src/components/grant-permissions.tsx)

