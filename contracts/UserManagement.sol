// SPDX-License-Identifier:MIT
pragma solidity 0.8.17;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath:addition overflow");
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns(uint256){
        require(b<=a,"SafeMath:subtraction overflow");
        uint256 c = a-b;
        return c;
    }
    function mul(uint256 a, uint256 b) internal pure returns(uint256){
        if(a==0){
            return 0 ;
        }
        uint c= a*b;
        require(c/a==b,"SafeMath: multiplication overflow");
        return c;
    }
    function div(uint256 a, uint256 b ) internal  pure returns(uint256){
        require(b>0,"Safemath: division by zero");
        uint256 c = a/b;
        return c;
    }
}

contract UserManagement {
    using SafeMath for uint256;
    uint256 userCount = 0 ;
    mapping (address => User) public users;
    struct User {
        uint256 UID;
        address wallet;
        string name;
        string email;
        string password;
        string pp;
        string bio;
    }
    event UserRegistered(uint256 UID,address wallet, string name, string email);
    event UserEdited(uint256 UID,address wallet, string name, string email);
    event UserDeleted(uint256 UID,address wallet, string name, string email);

    modifier isUserExist(){
        User storage user = users[msg.sender];
        require(bytes(user.name).length>0,"User: user not find");
        _;
    }
    modifier validateUserInfo(string name,string email,string password,string pp,string bio){
        require(bytes(name).length>0,"User: name requried");
        require(bytes(name).length>0,"User: email requried");
        require(bytes(name).length>0,"User: password requried");
        require(bytes(name).length>0,"User: pp requried");
        require(bytes(name).length>0,"User: bio requried");
        _;
    }
    function registerUser(string name,string email,string password,string pp,string bio) public returns(uint256){
        // your code goes here .
    }
}
