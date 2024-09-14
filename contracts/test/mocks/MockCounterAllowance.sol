// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {CounterAllowance} from "../../src/permissions/logic/CounterAllowance.sol";

contract MockCounterAllowance is CounterAllowance {
    function initializeCounterAllowance(
        address account,
        bytes32 permissionHash,
        CounterAllowanceDetails memory allowance
    ) public {
        _initializeCounterAllowance(account, permissionHash, allowance);
    }

    function useCounterAllowance(address account, bytes32 permissionHash) public {
        _useCounterAllowance(account, permissionHash);
    }
}
