// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console2} from "../../../lib/forge-std/src/Test.sol";

import {
    PermissionCallableCounterAllowanceBase,
    CounterAllowance
} from "../../base/PermissionCallableCounterAllowanceBase.sol";
import {PermissionedCounter} from "../../../src/PermissionedCounter.sol";

contract CounterInitalizePermissionTest is PermissionCallableCounterAllowanceBase {
    PermissionedCounter public counter;

    function setUp() public {
        counter = new PermissionedCounter();

        _initializePermissionContract();
    }

    function test_useCounterAllowance_success() public {
        // get smart account to set permission

        vm.prank(address(permissionManager));

        vm.expectEmit(address(permissionContract));
        emit CounterAllowance.CounterAllowanceInitialized(
            address(account), permissionHash, _createCounterAllowance(start, period, allowance)
        );
        permissionContract.initializePermission(
            account, permissionHash, abi.encode(_createPermissionValues(start, period, allowance, allowedContract))
        );
    }
}
