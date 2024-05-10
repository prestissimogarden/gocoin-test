// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

interface IERC20 {
    // Emitted when "value" tokens are moved from one account to another
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Emitted when the allowance of "spender" for an "owner" is set by a call to approve(). "value" is the new allowance
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // Tokens that exists
    function totalSupply() external view returns (uint256);

    // Tokens owned by "account"
    function balanceOf(address account) external view returns (uint256);

    // Moves falue from the caller to another address | bool indicates if succeeded (Emits transfer event)
    function transfer(address to, uint256 value) external returns (bool);

    // Returns remainder tokens that "spender" will be allowed to spend on behalf of "owner" through transferFrom()
    // Changes when approve() or transferFrom() are called
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    // Sets "value" as allowance of "spender" over the caller's tokens | bool indicates if succeeded (Emits approval event)
    function approve(address spender, uint256 value) external returns (bool);

    // Moves "value" amount of tokens from an address to another using the allowance mechanism, "value" is then deducted from the caller's allowance
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

contract GOCoin is IERC20 {
    string public constant name = "GOCoin";
    string public constant symbol = "GO";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;
    // How many alloweds an account have and how much they can spend
    mapping(address => mapping(address => uint256)) allowed;
    uint256 totalSupply_ = 10 ether;

    constructor() {
        // set the balance of the contract caller
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() external view override returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(
        address account
    ) external view override returns (uint256) {
        return balances[account];
    }

    function transfer(
        address to,
        uint256 value
    ) external override returns (bool) {
        // check if the caller has enough balance
        require(value <= balances[msg.sender]);

        // deduct the value from the caller and add to the target
        balances[msg.sender] -= value;
        balances[to] += value;

        // emit the event
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
        // see how much a spender can spend
        return allowed[owner][spender];
    }

    function approve(
        address spender,
        uint256 value
    ) external override returns (bool) {
        // designates an ammount of tokens that a spender can spend
        allowed[msg.sender][spender] = value;
        // emit the event
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external override returns (bool) {
        // From = Owner | Sender = Spender
        // Check if the spender has the balance to transfer and if is allowed to transfer that much
        require(value <= balances[from]);
        require(value <= allowed[from][msg.sender]);

        // Transfer and deducts the ammount from allowance left
        balances[from] -= value;
        allowed[from][msg.sender] -= value;
        balances[to] += value;

        // emit the event
        emit Transfer(from, to, value);
        return true;
    }
}
