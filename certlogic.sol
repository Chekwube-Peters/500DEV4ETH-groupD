pragma solidity ^0.6.1;

import "browser/500storage";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Certificate is ConStorage, Ownable, Roles, SafeMath {
    
    using Roles for Roles.Role;//declaring using Role library
    
    Roles.Role private adminsList; // holds Admins Roles
    Roles.Role private owner; //Holds Owner Roles
    Roles.Role students; //holds the Roles for students
    
    event newStudent(address indexed _address, bytes32 indexed _fName, string msg_1);
    //event upgradeparticip(address _msgsender, uint _id, uint testScores);
    event newAdmin(address indexed _admin, bytes32 name, string msg_1);
    event reactivateAStudent(address _address, bytes32 name, string msg_1);
    event reactivateAnAdmin(address _address, bytes32 name, string msg_1);
    //event donateToCourse(address _sender, uint _value); 
    //event awardCertific(address _awardee, MemberState _names, uint _id);
    event deactivateAStudent(address indexed _address, bytes32 name, string msg_2);
    event deactivateAnAdmin(address indexed _address, bytes32 name, string msg_2);
    

    constructor() public Ownable() {
        
    }
    //only owner can call certain function
    modifier onlyOwner {
        require(owner_1.has(msg.sender), "Not an owner account");
        _;
    }
    //only owner or admins can call certain function.
    modifier onlyOwnerOrAdmin() {
        require(owner_1.has(msg.sender) == true || admins.has(msg.sender) == true , "Not an authorized account.");
        _;
    }
    
    // constructor(address _owner) public payable {
    //     _owner = msg.sender;
    //     isAdminList[msg.sender] = true;
    // }
    
    //add admin(list restricted to 2)
    function setAdmin(address _address, bytes32 memory _name, bytes32 memory, _email) public onlyOwner returns(string) {
        require(adminList.length <= 2, "Can have only 2 Admins.");
        // isAdmin[_addr] = true;
        Admins memory _admins = adminsList[_address];
        _admins.name = _name;
        _admins.email = _email;
        _admins(adminCount[id]) = adminId++;
        adminList.push(_admins) -1;
        isAdminList(_name, _email) = true;
        isAdmin[_address] = true;
        return msg_1;
        
        emit newAdmin(_address, _name, msg_1);
    }

    // function checkAdmin(address _address) public view returns(bool) {
    //     require(isAdminList[_name] = true && adminList[_name] != adminList(0), "Not an admin");
    // }
    // function getAdminList() public view returns(Admins []) {
    //     return adminList;
    // }

     //get number of admins in list
    function countAdmin() public view returns(uint) {
        return adminList.length();
    }
    //returns number of students in a list
    function getNumberOfStudents() public view returns(uint) {
        return studentList.length();
    }
    
    function getStudent(bytes32 _email) public view returns(bytes32, bytes32, uint, uint, bool, uint, uint, string) {
      return (getStudentByEmail[_email].f_Name, getStudentByEmail[_email].l_Name, getStudentByEmail[_email].id, getStudentByEmail[_email].rating, getStudentByEmail[_email].isActivated, getStudentByEmail[_email].age, getStudentByEmail[_email].grade, getStudentByEmail[_email].githubLink);
    }

    function gradeStudent(address _address, uint _id, uint _testScores) public {
      require(instructor.has(msg.sender) || adminsList.has(msg.sender), "ONLY INSTRUCTOR OR ADMIN CAN GRADE STUDENT");
      require(students.has(_address), "THIS IS NOT A STUDENT ACCOUNT");

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
    // function () external payable{
    //     require(msg.value >= 0.5 ether, "Thank You, but you can only donate above 0.05 ether.");
    //     uint amount = msg.value;
    //     balanceOf[msg.sender] -= amount;
    // }

    //add student to list
    function setStudent( 
      address _address,
      bytes32 storage _fName, 
      bytes32 storage _lName, 
      bytes32 storage _email, 
      bytes32 storage _gitLink,
      uint32 _age
      ) public onlyAdminsOrOwner 
      returns(string) {
        Students memory _student = students[_address];
        _student.f_Name = _fName;
        _student.l_Name = _lName;
        _student.email = _email;
        _student.age = _age;
        _student.grade = currentGrade;
        _student.rating = 0;
        _student.cumulativeRating = 0;
        _student.isActivated = true;
        _student.githubLink = _gitLink;
        _student(nameCount[id]) = studentId++;
        studentList.push(_student) -1;
        state = MemberState(state);
        status = StudentStatus(status);
        isAStudent = true;
        
        return msg_1;

        emit newStudent(f_Name, l_Name, id);
    }
    //reactivate student
    function activateStudent(address _address) public onlyOwnerOrAdmin returns(bool) {
        Students storage _student = students[_address];
        _student.isActivated = true;
        status = StudentStatus(status) + 1;
        return true;

        emit reactivateAstudent(_address, name, msg_1);
    }
    //deactivate student
    function deactivateStudent(address _address) public onlyAdminsOrOwner returns(string) {
        Students storage _student = students[_address];
        _student.isActivated = false;
        status = StudentStatus[0];
        return msg_2;

        emit deactivateAstudent(_address, name, msg_2);
    }

    function getStudentGitLink(address _student) external returns(bytes32, string) {
        return(string(abi.encodePacked(students[_student].f_Name, "githubLink is ", students[_student.githubLink])));
    }
    function calculateRatings(uint[] rateParams, uint8 attendance, uint testscore, uint8 assignment) internal returns(uint) {
        //uint[] 
        uint8 punctPoint = 5;

        

    }

    function activateAdmin(address _address) public onlyOwner returns(bool) {
        Admins storage _admin = adminsList[_address];
        _admin.isActivated = true;
        return true;

        emit reactivateAnAdmin(_address, name, msg_1);
    } 
    function deactivateAdmin(address _address) public onlyOwner returns(string) {
        Admins storage _admin = adminsList[_address];
        _admin.isActivated = false;
        return msg_2;

        emit deactivateAnAdmin(_address, name, msg_2);
    }

    function createProjectTask(string storage _projectLink) public returns(bool success) {
      require(instructor.has(msg.sender) || adminsList.has(msg.sender), "ONLY INSTRUCTOR OR ADMIN CAN CREATE TASK");
      links.push(_projectLink);
      return true;
    }

    //function submitProjectTask(string _projectLink

    // function gradeStudent(byte32 _studentName, uint _id) public onlyAdminOrInstructor returns(uint, byte32) {
    //     //string(abi.encodePacked("My name is ", name));
    // }

    function awardCertificate(byte32 _studentName,  uint _id, byte32 _instructorName, uint _instructorId) external returns(byte32, uint, byte32, uint) {
      require(owner.has(msg.sender) || adminsList.has(msg.sender), "ONLY OWNER OR ADMIN IS ALLOWED");
      
      return createCertificate(_student, _id);
    }
}