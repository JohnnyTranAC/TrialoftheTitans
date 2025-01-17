public with sharing class GetEquivalencies {
    @AuraEnabled(cacheable=true)
    public static List<Equivalency__c> getEq(){
        id uid = UserInfo.getUserId();
        
     	List<Equivalency__c> strengths = 
            [SELECT Name, Skill_Equivalency__c 
             FROM Equivalency__c
             WHERE User__c = :uid ORDER BY Skill_Equivalency__c DESC LIMIT 5];
        System.debug(strengths);
        
        List<Map<String,String>> strengthsMap = new List<Map<String,String>>();
        for(Equivalency__c e : strengths) {
            strengthsMap.add(new Map<String, String>{'EquivalencyName' => e.Name, 'EquivalencyNum' => String.valueof(e.Skill_Equivalency__c)});            
        }
        System.debug(strengthsMap);

        return strengths;
    }

    @AuraEnabled
    public static void setEq(Integer eq, ID eqId){

        List<Equivalency__c> strength =
            [SELECT Id, Skill_Equivalency__c 
             FROM Equivalency__c
             WHERE Id = :eqId LIMIT 1];
        
        for(Equivalency__c e : strength) {
           e.Skill_Equivalency__c = eq;
           update e;
        }
        
    }
}
