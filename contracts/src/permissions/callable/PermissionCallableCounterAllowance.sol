// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IPermissionContract} from "../../../lib/smart-wallet-permissions/src/interfaces/IPermissionContract.sol";
import {UserOperation} from "../../../lib/smart-wallet-permissions/src/utils/UserOperationLib.sol";

import {CounterAllowance} from "../logic/CounterAllowance.sol";

contract PermissionCallableCounterAllowance is CounterAllowance, IPermissionContract {
    /// @notice Permission-specific values for this permission contract.
    struct PermissionValues {
        /// @dev Recurring native token allowance value (struct).
        CounterAllowanceDetails counterAllowance;
        /// @dev Single contract allowed to make custom external calls to.
        address allowedContract;
    }

    /// @notice Address of the permission manager.
    address permissionManager;

    /// @notice Constructor.
    ///
    /// @param permissionManager_ Address of the permission manager.
    constructor(address permissionManager_) {
        permissionManager = permissionManager_;
    }

    /// @notice Initialize the permission values.
    ///
    /// @dev Called by permission manager on approval transaction.
    ///
    /// @param account Account of the permission.
    /// @param permissionHash Hash of the permission.
    /// @param permissionValues Permission-specific values for this permission contract.
    function initializePermission(address account, bytes32 permissionHash, bytes calldata permissionValues) external {
        (PermissionValues memory values) = abi.decode(permissionValues, (PermissionValues));

        // check sender is permission manager
        if (msg.sender != permissionManager) revert InvalidInitializePermissionSender(msg.sender);

        _initializeCounterAllowance(account, permissionHash, values.counterAllowance);
    }

    /// @notice Use the counter allowance.
    ///
    /// @dev Called by permission manager on transaction.
    ///
    /// @param permissionHash Hash of the permission.
    function useCounterAllowance(bytes32 permissionHash) external {
        _useCounterAllowance({account: msg.sender, permissionHash: permissionHash});
    }

    /// @notice Validate the permission to execute a userOp.
    ///
    /// @dev Does not have access to certain storage values. Just checks selectors and addresses called are allowed
    ///
    /// @param permissionHash Hash of the permission.
    /// @param permissionValues Permission-specific values for this permission contract.
    /// @param userOp User operation to validate permission for.
    function validatePermission(bytes32 permissionHash, bytes calldata permissionValues, UserOperation calldata userOp)
        external
        view
    {
        // todo
    }
}
