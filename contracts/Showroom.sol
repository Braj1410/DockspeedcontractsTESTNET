// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//contract made for testing
contract Showroom is IERC721Receiver{
    
    
    uint256 public totalCarsinShowroom;
    
    IERC20 public Speed;
     IERC721 public DockSpeedNFT;
     
     mapping(uint256 => uint256)carDetails;
    
    constructor(IERC721 _dockspeedNFT){
        DockSpeedNFT = _dockspeedNFT;
    }
    
    event Bought(uint256 indexed tokenId,address indexed buyer);
    
    function buy(uint256 tokenId)public{
        
    }
    
   
   
     function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4){
        require(from == address(DockSpeedNFT),"Not allowed");
        return this.onERC721Received.selector;
    }
}