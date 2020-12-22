pragma solidity ^0.5.0;

import "@openzeppelin/upgrades/contracts/Initializable.sol";

import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/Roles.sol";

contract BurnerRole is Initializable, Context {
    using Roles for Roles.Role;

    event BurnerAdded(address indexed account);
    event BurnerRemoved(address indexed account);

    Roles.Role private _burners;

    function initialize(address sender) public initializer {
        if (!isBurner(sender)) {
            _addBurner(sender);
        }
    }

    modifier onlyBurner() {
        require(isBurner(_msgSender()), "BurnerRole: caller does not have the Burner role");
        _;
    }

    function isBurner(address account) public view returns (bool) {
        return _burners.has(account);
    }

    function addBurner(address account) public onlyBurner {
        _addBurner(account);
    }

    function renounceBurner() public {
        _removeBurner(_msgSender());
    }

    function _addBurner(address account) internal {
        _burners.add(account);
        emit BurnerAdded(account);
    }

    function _removeBurner(address account) internal {
        _burners.remove(account);
        emit BurnerRemoved(account);
    }

    uint256[50] private ______gap;
}
