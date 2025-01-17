/////////Partial Data Version posted on Discord on 01/19/2022 by Ashley Sarah Bee/////work by Ashley Bee, Nick D'Souza, Bao Nguyen///
///Creates data for Account, Curriculum__c, Cohort__c, Squad__c, Team__c, Titan__c, Skill__c////
///Clears Table before populating///
///Uses Single button component to delete and then create///

public with sharing class ApexDataFactoryPartial {
    static final String HeroTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Hero').getRecordTypeId();
    @Auraenabled
    public static void CreateCurriculum(){
        List <Curriculum__c> checkCurr = [SELECT Id From Curriculum__c];
        delete checkCurr;/*Clear Curriculum__c before new list*/
        
        //curriculum variables list
        // Name
        String[] technology = new List<String> {'Java','Salesforce'};

        //////////////////////////////////////////
        List<Curriculum__c> curriculum = new List<Curriculum__c>();
        
        //create a curriculum
        List<Curriculum__c> comparedCurriculum = [SELECT Name FROM Curriculum__c];
        
        if (comparedCurriculum.size() == 0){
            
            for (integer i=0; i<2; i++){
                Curriculum__c cur = new Curriculum__c();
                cur.Technology__c = technology[i];                
                cur.Name = cur.Technology__c;
                curriculum.add(cur);
            } 
            insert curriculum;
            
            
        }

        ////////////////////////////////
    }
    @AuraEnabled
     public static void CreateCohort(){
         List<Cohort__c> checkCoh = [SELECT Id FROM Cohort__c];
         delete checkCoh;/*Clear Cohort__c before new list*/
         //Create a list of cohorts to populate
         List <Cohort__c> newcohorts = new List<Cohort__c>();
         //Create a list of Curriculum to relate the cohorts to
         List <Curriculum__c> C = [SELECT Id, Name,CreatedDate FROM Curriculum__c];
         // cycle through curriculum and create a cohort for it
         for (Curriculum__c clm: C){
             system.debug(clm.CreatedDate.year());
             newcohorts.add( new Cohort__c (Name =clm.CreatedDate.year()+'-'+clm.CreatedDate.month()+'-'+clm.CreatedDate.day()+' '+ clm.Name + ' Cohort', 
                                             Active__c = false,
                                             Curriculum__c=clm.id
                                             ));
         } /*Cycle through the newly created list and set Active field to true for the Salesforce Cohort while leaving it set to false for Java*/
         for (Cohort__c ch:newcohorts){
             system.debug(ch.Name);
             If (ch.Curriculum__r.Name=='Salesforce')
             {
                 ch.Active__c=true;
             }
         }
         //insert the new list newcohorts
         try{
             insert newcohorts;}catch(DMLException e){system.debug(e);}
         
         }
    
    
     @Auraenabled
     public static void CreateTitan(){ 
         List <Titan__c> checkTi= [SELECT Id FROM Titan__C];
         delete checkTi;/*Clear Titan__c before new list*/
         //create a list of Titan Names leaving out the first
    List<String> TitanNames= new List<String>{
'01 - Declarative - Data Model',
'02 - Declarative - Org Configuration',
'03 - Declarative - Indexing',
'04 - Programmatic - Introduction to Apex',
'05 - Declarative - Security & Access',
'06 - Personal - Presentation Fundamentals',
'07 - Tools - Git & Github',
'08 - Declarative - Data Visualization',
'09 - Declarative - Chatter',
'10 - Declarative - Activities',
'11 - Tools - SDLC',
'12 - Programmatic - Apex Exceptions',
'13 - Tools - Debug Logs',
'14 - Tools - SFDX & Visual Studio Code',
'15 - Programmatic - SOQL',
'16 - Programmatic - SOSL',
'17 - Declarative - External Applications',
'18 - Declarative - Process Automation',
'19 - Declarative - Service Cloud',
'20 - Declarative - Sales Cloud',
'21 - Declarative - Data Management',
'22 - Programmatic - Apex Trigger Framework',
'23 - Programmatic - Apex Testing Framework',
'24 - Programmatic - HTML & CSS',
'25 - Programmatic - Visualforce',
'26 - Programmatic - Dynamic Apex',
'27 - Programmatic - Asynchronous Apex',
'28 - Programmatic - Apex Integration Services',
'29 - Programmatic - Apex Security & Sharing',
'30 - Programmatic - JavaScript',
'31 - Programmatic - Lightning Aura Component Framework',
'32 - Tools - Deployment',
'33 - Tools - Sandboxes',
'34 - Programmatic - Apex System & Schema Namespace Classes',
'35 - Declarative - User Setup',
'36 - Declarative - Auditing',
'37 - Platform - Order of Execution',
'38 - Programmatic - DML',
'39 - Platform - Governor Limits',
'40 - Programmatic - Modern Web Component Concepts',
'41 - Programmatic - Object-Oriented Principles in Apex',
'42 - Programmatic - Package Based Development',
'43 - Declarative - User Interface',
'44 - Declarative - Advanced Org Customizations',
'45 - Programmatic - Apex Best Practices',
'46 - Tools - Platform Events',
'47 - Programmatic - SLDS',
'48 - Programmatic - Lightning Web Components'
     };  /*create a list of Curricula filtered currently to Salesforce*/
         List<Curriculum__c> currs=[SELECT Id, Name, Technology__c FROM Curriculum__c WHERE Name='Salesforce'];
         List <Titan__c> newtitans = new List<Titan__c>();
         /*For the curriculum Salesforce cycle through the list of TitanNames and assign one name at a time to a new Titan*/
         for (Curriculum__c c:currs){
         for (String tname:TitanNames){
             system.debug(tname);
             newtitans.add(new Titan__c(Name=tname,
                           Curriculum__c= c.Id,
                           Technology__c=c.Technology__c));
             }
         } /*insert the new list of Titans*/
         try {insert newtitans;} catch(DMLException e){system.debug(e);}
         
}
    
@Auraenabled
public static void CreateTeam() {
    List<Team__c> checkT= [SELECT Id FROM Team__c];
    delete checkT;/*Clear Team__c before new list*/
        //teams variable list
        // Name
        // Squad_Sum__c – Roll up Summary (SUM) of Squad Score__c
        // In_Lead__c – Checkbox
        // 
		List<Team__c> teams = new List<Team__c>();
        
        String[] names = new List<String> {'Alchemy', 'Amplifire', 'Synergy', 'Vanquish'};
        String[] primaryColors = new List<String>{'red','yellow','blue'};
        String[] secondaryColors = new List<String>{'orange','purple','green'};
        List<String> slogans = new List<String>{'The true alchemists change the world into words.',
                'The price of greatness is responsibility.', 'Coming together is a beginning.',
                '...Vanquish...'};
                    
        for (integer i=0; i<names.size(); i++){
                Team__c newTeam = new Team__c();
                newTeam.name = names[i];
                newTeam.Slogan__c = slogans[i];       
     
        	Integer primaryColorsSelection = Integer.valueOf((Math.random()*(primaryColors.size())));
        	newTeam.Primary_Color__c = primaryColors[primaryColorsSelection];

        	Integer secondaryColorsSelection = Integer.valueOf((Math.random()*(secondaryColors.size())));
        	newTeam.Secondary_Color__c = secondaryColors[secondaryColorsSelection];
         
        	teams.add(newTeam);
        }
        
        insert teams;      
    }
     
    ////////////////////////////////////////////
    @Auraenabled
    public static void CreateSquad(){
        List<squad__c> checkS= [SELECT Id FROM Squad__c];
        delete checkS;/*Clear Squad__c before new list*/
        
        //Squad Variables
        //Name
        //Score__c – Number
        //Team__c -  Master detail reference to Team__c Object
        
        List<Team__c> teamIds = [SELECT Id FROM Team__c];
        List<Squad__c> squads = new List<Squad__c>();
        List<String> squadNames = new List<String>{'Habsburg Hopefuls','Dragonsalesforce','Seven Deadly Syns','Data Warriors'};
        Integer i = 0;
        for (Team__c t : teamIds){
            if (i < 4) {
                Squad__c newSquad = new Squad__c();
                newSquad.Name = squadNames[i];
                newSquad.Score__c = Integer.valueOf((Math.random()*1000));
                newSquad.Team__c = t.Id;
                	
                squads.add(newSquad);
                i++;
            }	           
         }       
    
        insert squads;      
    }

@Auraenabled
public static void CreateAccount(){
List<Account> checkA=[SELECT Id FROM Account];
        delete checkA;/*Clear Account before new list*/
        /* accounts variables list
        
        Name
        Email
        Phone
        Cohort__c – Lookup to Cohort__c Object
        Curriculum__c – Lookup to Curriculum__c Object
        Squad__c – Lookup to Squad__c Object
        Team__c –  Lookup to Team__c Object
        */

        ////////////////////////
        List<Account> accounts = new List<Account>(); 
        List<Cohort__c> cohorts = [SELECT Id, Curriculum__c FROM Cohort__c];
        List<Squad__c> squads = [SELECT Id, Team__c FROM Squad__c];
        List<Team__c> teams = [SELECT Id FROM Team__c];
        List<String> firstNames = new List<String>{'James', 'Mary', 'Robert', 'Patricia', 'John', 'Jennifer', 'Michael', 'Linda', 'William', 'Elizabeth', 'David', 'Barbara', 'Richard', 'Susan', 'Joeseph', 'Jessica', 'Thomas', 'Sarah', 'Charles', 'Karen', 'Christopher', 'Nancy', 'Daniel', 'Lisa', 'Matthew', 'Betty', 'Anthony', 'Margaret', 'Mark', 'Sandra', 'Donald', 'Ashley', 'Steven', 'Kimberly', 'Paul', 'Emily', 'Andrew', 'Donna', 'Seley', 'Badia', 'Joshua', 'Michelle', 'Kenneth', 'Dorothy', 'Kevin', 'Carol', 'Brian', 'Amanda', 'George', 'Melissa', 'Edward', 'Deborah', 'Ronald', 'Stephanie', 'Timothy', 'Rebecca', 'Jason', 'Sharon', 'Jeffrey', 'Laura', 'Ryan', 'Cynthia', 'Jacob', 'Kathleen', 'Gary', 'Amy', 'Nicholas', 'Shirley','Eric' , 'Angela', 'Jonathan', 'Helen', 'Mohamed', 'Sean', 'Caitlyn', 'Madeline'};
        List<String> lastNames = new List<String>{'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez', 'Ali', 'Wang', 'Devi', 'Nguyen', 'Gonzalez', 'Deng', 'Ivanov', 'Silva', 'Kim', 'Mohamed', 'Wilson', 'Anderson', 'Taylor', 'Moore', 'Lee', 'White', 'Allen', 'Wright', 'Hassan', 'Freeman'};
        
        //create an account
        //for each cohort, create 27 accounts
        integer teamIterator = 0;
        for(Cohort__c cohort : cohorts){
            for(integer i = 0; i < 27; i++){
                teamIterator += 1;
                if(teamIterator == 5){
                    teamIterator = 1;
                }
                Account hero = new Account();
                Integer fnNum = Integer.valueOf(Math.random() * firstNames.size());
                String firstName = firstNames[fnNum];
                Integer lnNum = Integer.valueOf(Math.random() * lastNames.size());
                String lastName = lastNames[lnNum];
                hero.Name = firstName + ' ' + lastName;
                hero.Phone = ('(' + Integer.valueOf((Math.random()*899)+100) + ')' + Integer.valueOf((Math.random()*899)+100) + '-' + Integer.valueOf((Math.random()*8999)+1000));
                hero.Cohort__c = cohort.Id;
                hero.Team__c = teams[teamIterator - 1].Id;
                for(Squad__c squad : squads){
                    if(squad.Team__c == hero.Team__c){    
                        hero.Squad__c = squad.Id;
                    }
                }
                hero.RecordTypeId = HeroTypeId;
                accounts.add(hero);
            }
        }
        insert accounts;
        
        
        
    }
    @AuraEnabled
    public static void CreateSkill(){
        //clear old data
     List<Skill__c> oldskills=[SELECT ID FROM Skill__c];
        delete oldskills;/*Clear Skill__c before new list*/
        // skills variable list
        // using Assigments__c field with typo instead of Assignments__c
        //Assignments__c - text
        //Skill_Breakdown__c - text
        // Name
        // Titan__c – Master Detail Reference to Titan__c Object
        
        String[] skillTypes = new List<String>{'Coding','Soft Skills', 'Exams', 'Data Management','Design'};

        ///////////////////////////////////////
        List<Skill__c> skills = new List<Skill__c>();
        List<Titan__c> titans = [SELECT Id FROM Titan__c];
        integer i = 1;
        // create a skill
        for(Titan__c titan:titans){
            Skill__c newSkill = new Skill__c();
            newSkill.Name = 'Skill ' + i;
            newSkill.Assigments__c = 'These are the assignments';
            newSkill.Skill_Breakdown__c = 'Breakdown of skills';
            integer pickSkill = integer.valueOf(Math.random()*skillTypes.size());
            newSkill.Skill_Type__c = skillTypes[pickSkill];
            newSkill.Titan__c = titan.id;
            skills.add(newSkill);
            i++;
        }
        
        insert skills;

        /////////////////////////////
    }
    

    
}
