// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console2} from "../../../lib/forge-std/src/Test.sol";

import {
    PermissionCallableCounterAllowanceBase,
    CounterAllowance
} from "../../base/PermissionCallableCounterAllowanceBase.sol";

contract CounterInitalizePermissionTest is PermissionCallableCounterAllowanceBase {
    function setUp() public {
        _initializePermissionContract();
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

    function test_initializePermission_success_setsState(
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

        permissionContract.initializePermission(
            account, permissionHash, abi.encode(_createPermissionValues(start, period, allowance, allowedContract))
        );

        CounterAllowance.CounterAllowanceDetails memory allowanceDetails =
            permissionContract.getCounterAllowanceDetails(account, permissionHash);
        assertEq(allowanceDetails.start, start);
        assertEq(allowanceDetails.period, period);
        assertEq(allowanceDetails.allowance, allowance);
    }
}
