//test

contract Test{
// uint256 public Lambo = 200**18;
//     uint256 public Muscle = 100**18;
//     uint256 public TurboMuscle =150*18;
//     uint256 public Supra = 130**18;
//     uint256 public Tracki = 20**18;
    
// function getPrice(uint256 _tokenId)public view returns(uint256 _price){
//         uint256 price;
//         string memory car = getSlice(0,2,CarData(_tokenId));
      
//      if(compare(car,"LA")){
//          price = Lambo;
//      }else if(compare(car,"MS")){
//          price = Muscle;
//      }else if(compare(car,"TM")){
//          price = TurboMuscle;
//      }else if(compare(car,"SP")){
//          price = Supra;
//      }else if(compare(car,"TI")){
//          price = Tracki;
//      }

//      return price;
//   }
  
//   function compare(string memory s1, string memory s2) public pure returns (bool) {
//         return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
//     }
    
  function getSlice(uint256 begin, uint256 end, string memory text) public view  returns (string memory ) {
        bytes memory a = new bytes(end-begin+1);
        for(uint i=0;i<=end-begin;i++){
            a[i] = bytes(text)[i+begin-1];
        }
        return string(a);    
    }
}