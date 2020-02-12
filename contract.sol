pragma solidity ^0.6.1;

import "*./contractStorage";

contract Certificate is ConStorage{

    
    event addStudent(string indexed _fName, string indexed _lName, uint _id);
    event upgradeparticip(address _msgsender, uint _id, uint testScores);
    event addAdminP(address _admin, string _name, uint id);
    event donateToCourse(address _sender, uint _value); 
    event awardCertific(address _awardee, MemberState _names, uint _id);
    
    modifier onlyOwner {
        require(msg.sender == owner, "Not an owner account");
        _;
    }
    
    modifier onlyOwnerOrAdmin() {
        require(msg.sender == owner || addminAddr[msg.sender] != 0 , "Not an authorized account.");
        _;
    }
    
    // constructor(address _owner) public payable {
    //     _owner = msg.sender;
    //     isAdminList[msg.sender] = true;
    // }
    
    function setAdmin(bytes32 memory _name, bytes32 memory, _email, uint _id) public onlyOwner returns(bool) {
        Admins memory _admins;
        _admins.name = _name;
        _admins.email = _email;
        _admins(adminCount[_id]) = id++;
        adminList.push(_admins) -1;
        require(_id <= 5, "Max Admin is restricted to 5.");
        isAdminList[_name] = true;
        return (isAdmin(true));
        
        emit addAdminP(_adminAdd, _name, _id);
        
        return true;
        
    }
    function checkAdmin(bytes32 _name) public view returns(bool) {
        require(isAdminList[_name] = true && adminList[_name] != adminList(0), "Not an admin");
    }

    function setAdminAddr(address _addr) public onlyOwnerOrAdmin returns(bool) {
        addminAddr[_addr] = Admins(name, email, id);
        return true;
    }
    
    // function getParticipants() public view returns(address[] memory) {
    //     return candidiateList;
    // }
    function getNumberOfStudents() public view returns(uint) {
        return studentList.length;
    }
    
    // function getParticipant(address _address) public view returns(string memory, string memory) {
    //     return (candidiates[_address].firstName, candidiates[_address].lastName);
    // }
    
    function upgradeParticipant(address _address, uint _id, uint _testScores) public onlyAdmins onlyOwner {
        grading[_id] = grade;
        require(grading[_id] == testScores && consistency == consistency && grade == grade);
        require(isMember[msg.sender] == true);
        testScores = _testScores;
        if(_testScores >= 5) {
            consistency = consistency + 2;
            if(testScores > 15 || testScores < 25 && consistency > 6 || consistency < 10){
                grade = testScores * consistency / 2;
                assert(grade * testScores > 0);
                if(grade >= 15) {
                    require(grade != 0 && testScores != 0 && consistency != 0);
                    state = MemberState(uint(state) + 1);
                    userLevel[_address] = state;
                }
            }
            
        }if(grade >= 40) {
            state = MemberState.intermediate;
        }if(grade >= 80) {
            state = MemberState.certified;
        }
        emit upgradeparticip(_address, _id, _testScores);
        
    }
    function () external payable{
        require(msg.value >= 0.5 ether, "Thank You, but you can only donate above 0.05 ether.");
        uint amount = msg.value;
        balanceOf[msg.sender] -= amount;
    }
    function setStudent( 
      bytes32 memory _fName, 
      bytes32 memory _lName, 
      bytes32 memory _email;
      ) public onlyAdminsOrOwner 
      returns(MemberState) {
        grading = 0;
        rating = 0;
        Students memory _student;
        _student.f_Name = _fName;
        _student.l_Name = _lName;
        _student.email = _email;
        _student(nameCount[id]) = studentId++;
        studentList.push(_student) -1;
        state = MemberState(state);
        isAStudent = true;
        return state;

        emit setStudent(f_Name, l_Name, id);
    }
    function setStudentAddress(address _addr) public onlyStudentAdminOrOWner returns(bool) {
        students[_addr] = Students(_fName, _lName, _id, _rating, email);
        return true;
    }
    function disableStudent() public onlyAdminsOrOwner {

    }

    //function setAdmin(byte32 _name, uint _id, byte32 _email) external onlyOwner returns(bool success) {

    }
    function popAdmin(byte32 _name, uint _id) internal {
        adminList.pop(_name, _id);

    } 
    function removeAdmin(byte32 _name, uint _id) external onlyOwner {

      bin.push()
      popAdmin(byte32 _name, uint _id)
    }

    function createTask(address _addr, uint _id, string memory _tasks) public onlyAdminOrInstructor returns(byte32, string memory) {

    }

    function gradeStudent(byte32 _studentName, uint _id) public onlyAdminOrInstructor returns(uint, byte32) {

    }

    function awardCertificate(byte32 _studentName,  uint _id, byte32 _instructorName, uint _instructorId) external onlyAdminsOrOwner returns(byte32, uint, byte32, uint) {

    }