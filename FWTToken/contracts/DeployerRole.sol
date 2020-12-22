pragma solidity ^0.5.0;

import "@openzeppelin/upgrades/contracts/Initializable.sol";

import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/Roles.sol";

contract DeployerRole is Initializable, Context {
    using Roles for Roles.Role;

    event DeployerAdded(address indexed account);

    Roles.Role private _deployers;

    function initialize(address sender) public initializer {
        if (!isDeployer(sender)) {
            _addDeployer(sender);
        }
    }

    modifier onlyDeployer() {
        require(isDeployer(_msgSender()), "DeployerRole: caller does not have the Deployer role");
        _;
    }

    function isDeployer(address account) public view returns (bool) {
        return _deployers.has(account);
    }

    function _addDeployer(address account) internal {
        _deployers.add(account);
        emit DeployerAdded(account);
    }

    uint256[50] private ______gap;
}
