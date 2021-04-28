// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Oracle {
    struct Data {
        uint256 date;
        uint256 payload;
    }

    mapping(address => bool) public reporters;
    mapping(bytes32 => Data) public data;

    address public admin;

    constructor(address _admin) {
        admin = _admin;
    }

    function updateReporter(address reporter, bool isReporter) external {
        require(msg.sender == admin, "only admin");

        reporters[reporter] = isReporter;
    }

    function updateData(bytes32 key, uint256 payload) external {
        require(reporters[msg.sender] == true, "only reporters");

        data[key] = Data(block.timestamp, payload);
    }

    function getData(bytes32 key)
        external
        view
        returns (
            bool result,
            uint256 date,
            uint256 payload
        )
    {
        if (data[key].date == 0) {
            return (false, 0, 0);
        }

        return (true, data[key].date, data[key].payload);
    }
}
