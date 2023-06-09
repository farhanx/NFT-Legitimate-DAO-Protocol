// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED
 * VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

/**
 * If you are reading data feeds on L2 networks, you must
 * check the latest answer from the L2 Sequencer Uptime
 * Feed to ensure that the data is accurate in the event
 * of an L2 sequencer outage. See the
 * https://docs.chain.link/data-feeds/l2-sequencer-feeds
 * page for details.
 */

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    constructor() {
        dataFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
    }

    /**
     * Returns the latest answer.
     */
    function getLatestData() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    /* Farhan comments:
    The returned price is an integer, so it is missing its decimal point. For example it is returning right now 2640200000000

        // Get the int256 value from the smart contract
            var int256Value = 2640200000000;

            // Split the int256 value into two parts, the integer part and the decimal part
            var integerPart = int256Value / 1000000000000000000;
            var decimalPart = int256Value % 1000000000000000000;

            // Convert the integer part to a number
            var integerNumber = parseInt(integerPart);

            // Convert the decimal part to a number
            var decimalNumber = parseFloat(decimalPart);

            // Add the two numbers together
            var convertedNumber = integerNumber + decimalNumber;

            console.log(convertedNumber); // 26402.0


        

    */
}
