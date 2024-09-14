// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {
    PermissionCallableCounterAllowanceBase, CounterAllowance
} from "./base/PermissionCallableCounterAllowanceBase.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is PermissionCallableCounterAllowanceBase {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_initializePermission_success_emitsEvent(
        address account,
        bytes32 permissionHash,
        uint48 start,
        uint48 period,
        uint160 allowance,
        address allowedContract
    ) public {
        vm.assume(start > 0);
        vm.assume(period > 0);

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
