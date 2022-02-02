// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AssetError {
    string public state = "onSale";

    error StateNotDefined(uint unit);

    function changeState(uint newState) public {
        // Método 2
        require(newState == 0 || newState == 1, "this state is not defined");

        if(newState == 0) {
            state = "onSale";
        } else if (newState == 1) {
            state = "notForSale";
        }

        // Método 1
        //else {
        //    revert StateNotDefined(newState)
        //}
    }
}