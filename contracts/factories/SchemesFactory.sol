pragma solidity ^0.4.24;

import "@optionality.io/clone-factory/contracts/CloneFactory.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

import "../controller/Avatar.sol";
import "../schemes/GenericScheme.sol";
import "../schemes/SimpleICO.sol";
import "../schemes/UpgradeScheme.sol";
import "../schemes/VestingScheme.sol";
import "../schemes/VoteInOrganizationScheme.sol";


contract SchemesFactory is Ownable, CloneFactory {

    address public genericSchemeLibraryAddress;
    address public simpleICOLibraryAddress;
    address public upgradeSchemeLibraryAddress;
    address public vestingSchemeLibraryAddress;
    address public voteInOrganizationSchemeLibraryAddress;


    event GenericSchemeLibraryChanged(address indexed _newLibraryAddress, address indexed _previousLibraryAddress);
    event SimpleICOLibraryChanged(address indexed _newLibraryAddress, address indexed _previousLibraryAddress);
    event UpgradeSchemeLibraryChanged(address indexed _newLibraryAddress, address indexed _previousLibraryAddress);    
    event VestingSchemeLibraryChanged(address indexed _newLibraryAddress, address indexed _previousLibraryAddress);
    event VoteInOrganizationSchemeLibraryChanged(address indexed _newLibraryAddress, address indexed _previousLibraryAddress);

    event GenericSchemeCreated(address _newSchemeAddress);
    event SimpleICOCreated(address _newSchemeAddress);
    event UpgradeSchemeCreated(address _newSchemeAddress);
    event VestingSchemeCreated(address _newSchemeAddress);
    event VoteInOrganizationSchemeCreated(address _newSchemeAddress);

    function setGenericSchemeLibraryAddress(address _genericSchemeLibraryAddress) external onlyOwner {
        emit GenericSchemeLibraryChanged(_genericSchemeLibraryAddress, genericSchemeLibraryAddress);

        genericSchemeLibraryAddress = _genericSchemeLibraryAddress;
    }

    function setSimpleICOLibraryAddress(address _simpleICOLibraryAddress) external onlyOwner {
        emit SimpleICOLibraryChanged(_simpleICOLibraryAddress, simpleICOLibraryAddress);

        simpleICOLibraryAddress = _simpleICOLibraryAddress;
    }

    function setUpgradeSchemeLibraryAddress(address _upgradeSchemeLibraryAddress) external onlyOwner {
        emit VoteInOrganizationSchemeLibraryChanged(_upgradeSchemeLibraryAddress, upgradeSchemeLibraryAddress);

        upgradeSchemeLibraryAddress = _upgradeSchemeLibraryAddress;
    }

    function setVestingSchemeLibraryAddress(address _vestingSchemeLibraryAddress) external onlyOwner {
        emit VestingSchemeLibraryChanged(_vestingSchemeLibraryAddress, vestingSchemeLibraryAddress);

        vestingSchemeLibraryAddress = _vestingSchemeLibraryAddress;
    }

    function setVoteInOrganizationSchemeLibraryAddress(address _voteInOrganizationSchemeLibraryAddress) external onlyOwner {
        emit VoteInOrganizationSchemeLibraryChanged(_voteInOrganizationSchemeLibraryAddress, voteInOrganizationSchemeLibraryAddress);

        voteInOrganizationSchemeLibraryAddress = _voteInOrganizationSchemeLibraryAddress;
    }

    function createGenericScheme(
        Avatar _avatar,
        IntVoteInterface _intVote,
        bytes32 _voteParams,
        address _contractToCall
    ) public returns (address) 
    {
        address clone = createClone(genericSchemeLibraryAddress);
        GenericScheme(clone).init(
            _avatar,
            _intVote,
            _voteParams,
            _contractToCall
        );
        
        emit GenericSchemeCreated(clone);

        return clone;
    }

    function createSimpleICO(
        Avatar _avatar,
        uint _cap,
        uint _price,
        uint _startBlock,
        uint _endBlock,
        address _beneficiary
    ) public returns (address) 
    {
        address clone = createClone(simpleICOLibraryAddress);
        SimpleICO(clone).init(
            msg.sender,
            _avatar,
            _cap,
            _price,
            _startBlock,
            _endBlock,
            _beneficiary
        );
        
        emit SimpleICOCreated(clone);

        return clone;
    }

    function createUpgradeScheme(
        Avatar _avatar,
        IntVoteInterface _intVote,
        bytes32 _voteParams
    ) public returns (address) 
    {
        address clone = createClone(upgradeSchemeLibraryAddress);
        UpgradeScheme(clone).init(
            _avatar,
            _intVote,
            _voteParams
        );
        
        emit UpgradeSchemeCreated(clone);

        return clone;
    }

    function createVestingScheme(
        Avatar _avatar,
        IntVoteInterface _intVote,
        bytes32 _voteParams
    ) public returns (address) 
    {
        address clone = createClone(vestingSchemeLibraryAddress);
        VestingScheme(clone).init(
            _avatar,
            _intVote,
            _voteParams
        );
        
        emit VestingSchemeCreated(clone);

        return clone;
    }

    function createVoteInOrganizationScheme(
        Avatar _avatar,
        IntVoteInterface _intVote,
        bytes32 _voteParams
    ) public returns (address) 
    {
        address clone = createClone(voteInOrganizationSchemeLibraryAddress);
        VoteInOrganizationScheme(clone).init(
            _avatar,
            _intVote,
            _voteParams
        );
        
        emit VoteInOrganizationSchemeCreated(clone);

        return clone;
    }
}