// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";




contract DodgeSpeedNFT is ERC721("DodgeSpeed","DS"),ERC721Enumerable,IERC721Receiver,Ownable{
    
    uint256 public totalTokens;
    uint256 public TotalCarsForAuction;
    
    address public minter;
    
    uint256 public Lambo = 200*10**18;
    uint256 public Muscle = 100*10**18;
    uint256 public TurboMuscle =150*10**18;
    uint256 public Supra = 130*10**18;
    uint256 public Tracki = 20*10**18;
    
    IERC20 public Speed;
    mapping(uint256 => string)private TokenURI;
    mapping(uint256 => string)private _CarData;
    mapping(uint256=> Auction)private CarAuction;

    struct Auction{
        uint256 tokenId;
        uint256 price;
        uint256 blockNumber;
        bool sold;
    }
    
    event Dictionary(uint256 indexed Index,uint256 indexed tokenId);

    event SoldCar(uint256 indexed Token,address indexed Buyer);
    
    constructor(IERC20 _speed,address _minter){
        minter = _minter;
        Speed = _speed;
    }
    
  function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
    return super.supportsInterface(interfaceId);
  }

  function mint(address _to,string memory _tokenURI,string memory _carData)public onlyMinter{
      uint256  TotalSupply = totalTokens;
      _mint(_to,TotalSupply);
      TokenURI[TotalSupply] = _tokenURI;
      _CarData[TotalSupply] = _carData;
      totalTokens++;
  }
  
  
  function CarData(uint256 _tokenId)public view returns(string memory _carData){
      return _CarData[_tokenId];
  }
  
  function tokenURI(uint256 _tokenId) public view override  returns(string memory _tokenURI){
      return TokenURI[_tokenId];
  }

 function getPrice(uint256 _tokenId)public view returns(uint256 _price){
        uint256 price;
        string memory car = getSlice(1,2,CarData(_tokenId));
      
     if(compare(car,"LA")){
         price = Lambo;
     }else if(compare(car,"MS")){
         price = Muscle;
     }else if(compare(car,"TM")){
         price = TurboMuscle;
     }else if(compare(car,"SP")){
         price = Supra;
     }else if(compare(car,"TI")){
         price = Tracki;
     }

     return price;
  }
  
 
  
  function buyCar(uint256 _index)public{
      uint256 tokenId = CarAuction[_index].tokenId;
      
      
      uint256 price= getPrice(tokenId);

     require(Speed.allowance(msg.sender,address(this)) >= price,"Approve Enough Speed token to buy a car");
     
     Speed.transferFrom(msg.sender,address(this),price);
     this.safeTransferFrom(address(this),msg.sender,tokenId);
     
     CarAuction[_index].sold = true;


     emit SoldCar(tokenId,msg.sender);
  }
  
  function getSlice(uint256 begin, uint256 end, string memory text) private pure  returns (string memory ) {
        bytes memory a = new bytes(end-begin+1);
        for(uint i=0;i<=end-begin;i++){
            a[i] = bytes(text)[i+begin-1];
        }
        return string(a);    
    }
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4){
        
        CarAuction[TotalCarsForAuction] =  Auction({
            tokenId: tokenId,
            price: getPrice(tokenId),
            blockNumber: block.number,
            sold: false

        });
        emit Dictionary(TotalCarsForAuction,tokenId);
        TotalCarsForAuction++;
        
        return this.onERC721Received.selector;
    }
    
    function compare(string memory s1, string memory s2) private pure returns (bool) {
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
    
    function changeMinter(address _minter) public onlyOwner{
        minter = _minter;
    }
    
    modifier onlyMinter{
        require(msg.sender == minter,"Minter is allowed to mint tokens");
        _;
    }
    
    
}