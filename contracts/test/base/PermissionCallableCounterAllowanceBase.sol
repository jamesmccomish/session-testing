// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console2} from "../../lib/forge-std/src/Test.sol";
import {CoinbaseSmartWallet} from "../../lib/smart-wallet-permissions/lib/smart-wallet/src/CoinbaseSmartWallet.sol";

import {IPermissionCallable} from "../../lib/smart-wallet-permissions/src/interfaces/IPermissionCallable.sol";

import {CounterAllowance} from "../../src/permissions/logic/CounterAllowance.sol";
import {PermissionCallableCounterAllowance as PermissionContract} from
    "../../src/permissions/callable/PermissionCallableCounterAllowance.sol";

import {CounterAllowanceBase} from "./CounterAllowanceBase.sol";
import {PermissionManagerBase} from "../../lib/smart-wallet-permissions/test/base/PermissionManagerBase.sol";

contract PermissionCallableCounterAllowanceBase is PermissionManagerBase, CounterAllowanceBase {
    PermissionContract permissionContract;
    uint256 constant MAGIC_SPEND_MAX_WITHDRAW_DENOMINATOR = 20;

    function _initializePermissionContract() internal {
        _initializePermissionManager();

        permissionContract = new PermissionContract(address(permissionManager));
    }

    function _createPermissionValues(uint48 start, uint48 period, uint160 allowance, address allowedContract)
        internal
        pure
        returns (PermissionContract.PermissionValues memory)
    {
        return PermissionContract.PermissionValues({
            counterAllowance: _createCounterAllowance(start, period, allowance),
            allowedContract: allowedContract
        });
    }

    function _createPermissionValues(uint160 allowance, address allowedContract)
        internal
        pure
        returns (PermissionContract.PermissionValues memory)
    {
        return PermissionContract.PermissionValues({
            counterAllowance: _createCounterAllowance({start: 1, period: type(uint24).max, allowance: allowance}),
            allowedContract: allowedContract
        });
    }

    function _createPermissionedCall(address target, uint256 value, bytes memory data)
        internal
        pure
        returns (CoinbaseSmartWallet.Call memory)
    {
        return CoinbaseSmartWallet.Call({
            target: target,
            value: value,
            data: abi.encodeWithSelector(IPermissionCallable.permissionedCall.selector, data)
        });
    }
}
