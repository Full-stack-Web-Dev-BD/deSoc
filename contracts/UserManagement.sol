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
    event UserRegistered(uint256 UID, address indexed wallet, string name, string email);
    event UserUpdated(uint256 UID, address indexed wallet, string name, string email);
    event UserDeleted(uint256 UID, address indexed wallet, string name, string email);

    modifier userExist(address wallet){ 
        User storage user = users[wallet];
        require(bytes(user.name).length>0,"User: user not find");
        
        _;
    }
    modifier userNotExist(){
        User storage user = users[msg.sender];
        require(bytes(user.name).length==0,"User: user already registered");
        _;
    }
    modifier validateUserInfo(string memory name,string memory email,string memory password,string memory pp,string memory bio){
        require(bytes(name).length>0,"User: name requried");
        require(bytes(email).length>0,"User: email requried");
        require(bytes(password).length>0,"User: password requried");
        require(bytes(pp).length>0,"User: pp requried");
        require(bytes(bio).length>0,"User: bio requried");
        _;
    }
    function registerUser(string memory _name,string memory _email,string memory _password,string memory _pp,string memory _bio) public validateUserInfo(_name,_email,_password,_pp,_bio) userNotExist returns(uint256){
        userCount++;
        User memory newUser =  User(userCount,msg.sender, _name, _email,_password, _pp, _bio );
        users[msg.sender]=newUser;
        emit UserRegistered(userCount, msg.sender, _name, _email);
        return userCount;
    }
    function updateProfile(string memory _name, string memory _email, string memory _password, string memory _pp, string memory _bio) public userExist(msg.sender) validateUserInfo(_name, _email, _password, _pp, _bio) returns (bool) {
        User storage existingUser = users[msg.sender];
        existingUser.name = _name;
        existingUser.email = _email;
        existingUser.password = _password;
        existingUser.pp = _pp;
        existingUser.bio = _bio;
        emit UserUpdated(existingUser.UID, msg.sender, existingUser.name, existingUser.email);
        return true;
    }

    function deleteAccount() public userExist(msg.sender) returns(bool){
        delete users[msg.sender];
        return true;
    }
    function getUser(address _wallet) public view userExist(_wallet) returns( User memory ){
        User storage user= users[_wallet];
        return user;
    }
}
