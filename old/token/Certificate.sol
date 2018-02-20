pragma solidity ^0.4.20;

// to develop a token to buy and sell certificates
// the certificate data is transferred via transactions
// on eth blockchain

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}


/**
* @title ERC20 Specifications
* https://github.com/ethereum/EIPs/issues/20
*/

contract Token {

	/*
	* @return Returns total supply of tokens
	*/
  function totalSupply() public view returns (uint256);

	/*
	* @param _owner: The address from which we retrieve number of tokens
	* @return Returns balance of address
	*/
  function balanceOf(address _owner) public view returns (uint256);

	/*
	* @notice send '_value' token to '_to' from 'msg.sender'
	* @param _to: The address we want to send tokens to
	* @param _value: The number of tokens to be transferred
	* @return Returns true if transfer was successful, returns false otherwise 
	*/
  function transfer(address _to, uint256 _value) public returns (bool);
  event Transfer(address indexed _from, address indexed _to, uint256 _value);

	/*
	* @notice send '_value' token to '_to' from '_from' on the condition it is approved by '_from'
	* @param _from: The address of the sender
	* @param _to: The address of the recipient
	* @param _value: The amount of token to be transferred
	* @return Returns true if transfer was successful, returns false otherwise
	*/
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool) 
}

contract BasicToken is ERC20Basic {
  using SafeMath for uint256;

  mapping(address => uint256) balances;

  uint256 totalSupply_;

  /**
  * @dev total number of tokens in existence
  */
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balnaces[msg.sender]);
    Transfer(msg.sender, _to, _value);
    return true; 
  }

  /**
  * @dev Gets the balance for the specified address.
  * @param _owner The address to query the balance of the owner
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
  }
}

contract ERC20Token is BasicToken {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}


// Certificate User Stories
// I can be forgotten
// I can award certificates
// I can stake identity
// I can check who is the the sender and recipient of the certificate
// I know what the certificate is about
// I can send the certificate to a person to verify
// I can restrict the kind of information I want people to see

contract Certificate is StandardToken {
  struct certData {
    // address of the originator
    address originator;
    // address of the recipient
    address recipient;

    // Description of the certificate
		// will be encrypted
    string description;

    // valid duration of the certificate
    // if the certificate is to last indefinitely
    // endTime = startTime
    // forever = true
    uint startTime;
    uint endTime;
    bool forever;
  }

  function sendCertificate(address recipient){
  }
  
}

