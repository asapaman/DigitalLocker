pragma solidity >=0.4.25 <0.6.0;

contract DigitalLocker
{
    enum StateType { Requested, DocumentReview, Terminated }
    address public Owner;
    address public BankAgent;
    string public LockerFriendlyName;
    string public LockerIdentifier;
    address public CurrentAuthorizedUser;
    string public Image;
    string public LockerStatus;
    string public RejectionReason;
    StateType public State;

    constructor(string memory lockerFriendlyName, address bankAgent) public
    {
        Owner = msg.sender;
        LockerFriendlyName = lockerFriendlyName;

        State = StateType.DocumentReview; //////////////// should be StateType.Requested?

        BankAgent = bankAgent;
    }

    function BeginReviewProcess() public
    {
        
        if (Owner != msg.sender)
        {
            revert();
        }
        BankAgent = msg.sender;

        LockerStatus = "Pending";
        State = StateType.DocumentReview;
    }

    function RejectApplication(string memory rejectionReason) public
    {
        if (BankAgent != msg.sender)
        {
            revert();
        }

        RejectionReason = rejectionReason;
        LockerStatus = "Rejected";
        State = StateType.DocumentReview;
    }

    function UploadDocuments(string memory lockerIdentifier, string memory image) public
    {
        if (BankAgent != msg.sender)
        {
            revert();
        }
        LockerStatus = "Approved";
        Image = image;
        LockerIdentifier = lockerIdentifier;

    }
    
    
    function Terminate() public
    {
        if (Owner != msg.sender)
        {
            revert();
        }
        CurrentAuthorizedUser = 0x0000000000000000000000000000000000000000;
        State = StateType.Terminated;
    }
}
