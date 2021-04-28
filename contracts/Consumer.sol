// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IOracle.sol";

contract Consumer {
    IOracle public oracle;

    constructor(address _oracle) {
        oracle = IOracle(_oracle);
    }

    function fetchData() external view returns (uint256) {
        bytes32 key = keccak256(abi.encodePacked("BTC/USD"));

        (bool result, uint256 timestamp, uint256 data) = oracle.getData(key);

        require(result == true, "data does not exist");
        require(timestamp >= block.timestamp - 2 minutes, "data expired");

        return data;
    }
}
