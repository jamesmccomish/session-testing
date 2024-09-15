// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {PermissionCallable} from "../lib/smart-wallet-permissions/src/mixins/PermissionCallable.sol";

import {Counter} from "./Counter.sol";

contract PermissionedCounter is Counter, PermissionCallable {
    Counter public counter;

    constructor(address _counter) {
        counter = Counter(_counter);
    }

    function incrementCounter() external {
        counter.increment();
    }

    function decrementCounter() external {
        counter.decrement();
    }

    /// @dev Only the increment function is allowed to be called
    function supportsPermissionedCallSelector(bytes4 selector) public view override returns (bool) {
        return selector == this.incrementCounter.selector;
    }
}
