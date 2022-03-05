// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


interface IFactory{
   function CarData(uint256 _tokenId)external view returns(string memory _carData);
}
