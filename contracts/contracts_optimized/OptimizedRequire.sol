// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedRequire {
    uint8  COOLDOWN = 1 minutes;
    uint32 lastPurchaseTime;

    function purchaseToken() external payable {
        require(
            msg.value == 0.1 ether &&
                block.timestamp > lastPurchaseTime + COOLDOWN,
            "cannot purchase"
        );
        lastPurchaseTime = uint32(block.timestamp);
        // mint the user a token
    }
}
