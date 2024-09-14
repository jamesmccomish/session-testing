// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {CounterAllowance} from "../../src/permissions/logic/CounterAllowance.sol";

import {MockCounterAllowance} from "../mocks/MockCounterAllowance.sol";

contract CounterAllowanceBase {
    MockCounterAllowance mockCounterAllowance;

    function _initializeCounterAllowance() internal {
        mockCounterAllowance = new MockCounterAllowance();
    }

    function _createCounterAllowance(uint48 start, uint48 period, uint160 allowance)
        internal
        pure
        returns (CounterAllowance.CounterAllowanceDetails memory)
    {
        return CounterAllowance.CounterAllowanceDetails(start, period, allowance);
    }
}
