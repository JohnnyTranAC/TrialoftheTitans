@isTest
public class PathToTitanControllerTest {
    @testSetup
    static void testSetup() {
        Curriculum__c curriculum = new Curriculum__c(Name='Salesforce v5.1.1');
        insert curriculum;
        Cohort__c cohort = new Cohort__c(Name='Jan 20');
        insert cohort;
        Team__c team = new Team__c(Name='Alchemy');
        insert team;
        Squad__c squad = new Squad__c(Name='Fullmetal', Team__c=team.Id);
        insert squad;
        Account account = new Account(
            Name='Registrants',
            Squad__c=squad.Id,
            Team__c=team.Id,
            Cohort__c=cohort.Id,
            Curriculum__c=curriculum.Id
        );
        insert account;
        Contact contact = new Contact(
            FirstName='John',
            LastName='Smith',
            AccountId=account.Id
        );
        insert contact;
        
        List<Certification_Exam__c> certExams = new List<Certification_Exam__c>{
        new Certification_Exam__c(Name='State Alchemist License')
        };
		insert certExams;
        Certification__c cert = new Certification__c(
            Certification_Exam__c=certExams[0].Id,
            Date_Issued__c=Date.newInstance(2022, 1, 20),
            Image_URL__c='https://example.com/image.png',
            Verification_Site__c='https://example.com',
            Assessor__c='Amestria',
            Candidate__c = contact.Id,
            User__c=UserInfo.getUserId()
        );
        insert cert;
        
        Education__c edu = new Education__c(
            Name='State Military',
            Portfolio_Status__c='In Progress',
            User__c=UserInfo.getUserId()
        );
        insert edu;
        
        List<Titan__c> titans = new List<Titan__c>{
            new Titan__c(Name='00 - Misc - Lesson 0', Curriculum__c=curriculum.Id, Technology__c='Salesforce'),
            new Titan__c(Name='01 - Declarative - Lesson 1', Curriculum__c=curriculum.Id, Technology__c='Salesforce'),
            new Titan__c(Name='02 - Programmatic - Lesson 2', Curriculum__c=curriculum.Id, Technology__c='Salesforce')    
        };
        insert titans;
        
        List<Exam__c> exams = new List<Exam__c>{
            new Exam__c(Name='Exam 0', Titan__c=titans[0].Id),
            new Exam__c(Name='Exam 1', Titan__c=titans[1].Id),
            new Exam__c(Name='Exam 2', Titan__c=titans[2].Id)
        };
        insert exams;
            
        List<Exam_Result__c> results = new List<Exam_Result__c>{
            new Exam_Result__c(Account__c=account.Id, Exam__c=exams[0].Id),
            new Exam_Result__c(Account__c=account.Id, Exam__c=exams[0].Id),
            new Exam_Result__c(Account__c=account.Id, Exam__c=exams[0].Id)
        };
        insert results;
        
        Exam_Question__c question = new Exam_Question__c(Name='Question 0');
        insert question;
        
        List<Hero_Answer__c> answers = new List<Hero_Answer__c>{
            new Hero_Answer__c(Exam_Result__c=results[0].Id, Exam_Question__c=question.Id, Correct__c=false),
            new Hero_Answer__c(Exam_Result__c=results[0].Id, Exam_Question__c=question.Id, Correct__c=false),
            new Hero_Answer__c(Exam_Result__c=results[1].Id, Exam_Question__c=question.Id, Correct__c=true),
            new Hero_Answer__c(Exam_Result__c=results[1].Id, Exam_Question__c=question.Id, Correct__c=false),
            new Hero_Answer__c(Exam_Result__c=results[2].Id, Exam_Question__c=question.Id, Correct__c=true),
            new Hero_Answer__c(Exam_Result__c=results[2].Id, Exam_Question__c=question.Id, Correct__c=true)    
        };
        insert answers;
    }
    
	@isTest
    static void getContactTest() {
        Contact soqlContact = [SELECT AccountId FROM Contact WHERE Name='John Smith'];
        Contact contact = SidebarController.getContact();
        System.assertEquals(contact, soqlContact);
    }
    
    @isTest
    static void getAccountTest() {
        Account soqlAccount = [SELECT Name, Squad__c, Team__c, Cohort__c FROM Account WHERE Name='Registrants'];
        Account account = SidebarController.getAccount();
        System.assertEquals(account, soqlAccount);
    }
    
    @isTest
    static void getSquadTest() {
        Squad__c soqlSquad = [SELECT Name FROM Squad__c WHERE Name='Fullmetal'];
        Squad__c squad = SidebarController.getSquad();
        System.assertEquals(squad, soqlSquad);
    }
    
    @isTest
    static void positiveTest() {
        Titan__c t = [SELECT ID, Name FROM Titan__c WHERE Name='00 - Misc - Lesson 0'];
        Account a = [SELECT ID, Name FROM Account WHERE Name='Registrants'];
        List<Exam_Result__c> examResults = new List<Exam_Result__c>();
        examResults = [SELECT Exam__c, Exam__r.Name, Status__c, CreatedDate FROM Exam_Result__c WHERE Exam__r.Titan__c=:t.id AND Account__c =:a.id ORDER BY Status__c];
        List<Exam_Result__c> eR = new List<Exam_Result__c>();
        eR = PathToTitanController.getExamAndResultsList(t.Id, a.Id);
        System.assertEquals(eR, examResults);
    }
    
    @isTest
    static void negativeTest() {    
        try {
        Titan__c t = [SELECT ID, Name FROM Titan__c WHERE Name='No exist'];
        Account a = [SELECT ID, Name FROM Account WHERE Name='Registrants'];
        List<Exam_Result__c> examResults = new List<Exam_Result__c>();
            examResults = [SELECT ID FROM Exam_Result__c WHERE Exam__r.Titan__c=:t.id AND Account__c =:a.id];
        } catch (Exception e) {
            System.assert(e.getMessage().contains('List has no rows for assignment to SObject'), e.getMessage());           
        }
    }
}