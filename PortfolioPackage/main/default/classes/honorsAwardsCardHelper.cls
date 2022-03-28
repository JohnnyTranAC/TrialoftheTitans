public with sharing class honorsAwardsCardHelper {
    @AuraEnabled(cacheable=true)
    public static List<Award__c> getAwards() {
        id userID=UserInfo.getUserId();
        
        List <Award__c> Awards= [SELECT Name, Date_Received__c FROM Award__c WHERE User__c=:userId];
        system.debug(Awards);
        return Awards;
    }
}