// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {IStdReference} from "./interfaces/IStdReference.sol";

/// @title BandWorkshop
/// @notice A simple contract that demonstrates how to use the Band Standard Reference contract
/// @author @hazardcookie
contract BandWorkshop2 {
    IStdReference public ref;

    /// @param _ref The address of the Band Standard Reference contract
    constructor(IStdReference _ref) {
        ref = _ref;
    }

    /// @notice Get the price of a base/quote pair
    /// @param _symbol The symbol of the base asset
    /// @param _base The symbol of the quote asset
    /// @return The price data for the given base/quote pair
    function getPrice(string memory _symbol, string memory _base)
        external
        view
        returns (IStdReference.ReferenceData memory)
    {
        return ref.getReferenceData(_symbol, _base);
    }

    /// @notice Get the price of multiple base/quote pairs
    /// @param _bases The symbols of the base assets
    /// @param _quotes The symbols of the quote assets
    /// @return The price data for the given base/quote pairs
    function getBulkPrice(string[] memory _bases, string[] memory _quotes)
        external
        view
        returns (uint256[] memory)
    {
        IStdReference.ReferenceData[] memory data = ref.getReferenceDataBulk(_bases, _quotes);

        uint256[] memory prices = new uint256[](data.length);
        for (uint256 i = 0; i < data.length; i++) {
            prices[i] = data[i].rate;
        }

        return prices;
    }
}
