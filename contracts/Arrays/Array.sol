// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Array {

    struct Numbers {
        uint value;
    }

    Numbers[] public numbers;

    function addNumbers(uint n) public {
        numbers.push(Numbers(n));
    }

    function removeNumber() public {
        numbers.pop();
    }
}