// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

abstract contract CounterAllowance {
    event CounterAllowanceInitialized(
        address indexed account, bytes32 indexed permissionHash, CounterAllowanceDetails allowance
    );

    error CounterAllowanceExceeded();

    struct CounterAllowanceDetails {
        /// @dev Start time of the allowance (unix seconds).
        uint48 start;
        /// @dev Time duration (seconds).
        uint48 period;
        /// @dev Maximum allowed value to spend
        uint160 allowance;
    }

    /// @notice Packed recurring allowance values (start, period) for the permission.
    mapping(address account => mapping(bytes32 permissionHash => CounterAllowanceDetails)) internal _recurringAllowances;

    function getCounterAllowanceDetails(address account, bytes32 permissionHash)
        public
        view
        returns (CounterAllowanceDetails memory)
    {
        return _recurringAllowances[account][permissionHash];
    }

    function _initializeCounterAllowance(
        address account,
        bytes32 permissionHash,
        CounterAllowanceDetails memory allowance
    ) internal {
        _recurringAllowances[account][permissionHash] = allowance;
        emit CounterAllowanceInitialized(account, permissionHash, allowance);
    }

    function _useCounterAllowance(address account, bytes32 permissionHash) internal {
        CounterAllowanceDetails storage allowance = _recurringAllowances[account][permissionHash];
        require(allowance.start <= block.timestamp, "CounterAllowance: allowance not started");
        require(allowance.start + allowance.period >= block.timestamp, "CounterAllowance: allowance expired");
        if (allowance.allowance > 0) {
            allowance.allowance--;
        } else {
            revert CounterAllowanceExceeded();
        }
    }
}
