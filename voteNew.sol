pragma solidity ^0.4.11;

contract voteContract {

    mapping (address => bool) voters; // �ϳ��� ���� �� �� ���� ��ǥ�� ����
    mapping (string => uint) candidates; // �ĺ����� ��ǥ���� �����մϴ�.
    mapping (uint8 => string) candidateList; // �ĺ����� ����Ʈ�Դϴ�.

    uint8 numberOfCandidates; // �� �ĺ����� ���Դϴ�.
    address contractOwner;

    function voteContract() public {
        contractOwner = msg.sender;
    }

    // �ĺ��ڸ� �߰��ϴ� �Լ��Դϴ�.
    function addCandidate(string cand) public {
        bool add = true;
        for (uint8 i = 0; i < numberOfCandidates; i++) {
        
            // ���ڿ� �񱳴� �ؽ��Լ�(sha3)�� ���ؼ� �� �� �ֽ��ϴ�.
            // �ָ���Ƽ���� ���ڿ� �񱳿� ���� Ư���� �Լ��� �����ϴ�.
            if(keccak256(candidateList[i]) == keccak256(cand)){
                add = false; break;
            }
        }

        if(add) {
            candidateList[numberOfCandidates] = cand;
            numberOfCandidates++;
        }
    }

    // ��ǥ�� �ϴ� �Լ��Դϴ�.
    function vote(string cand) public {
        // �ϳ��� ������ �ѹ��� ��ǥ�� ����� �ݿ��˴ϴ�.
        if(voters[msg.sender]) { }
        else{
            voters[msg.sender] = true;
            candidates[cand]++;
        }
    }

    // �̹� ��ǥ�ߴ��� Ȯ���մϴ�.
    function alreadyVoted() public constant returns(bool)  {
        if(voters[msg.sender])
            return true;
        else
            return false;
    }

    //�ĺ����� ���� �����մϴ�.
    function getNumOfCandidates() public constant returns(uint8) {
        return numberOfCandidates;
    }

    //��ȣ�� �ش��ϴ� �ĺ��� �̸��� �����մϴ�.
    function getCandidateString(uint8 number) public constant returns(string) {
        return candidateList[number];
    }

    //�ĺ��� ��ǥ���� �����մϴ�.
    function getScore(string cand) public constant returns(uint) {
        return candidates[cand];
    }

    //��Ʈ��Ʈ�� �����մϴ�.
    function killContract() public {
        if(contractOwner == msg.sender)
            selfdestruct(contractOwner);
    }
}