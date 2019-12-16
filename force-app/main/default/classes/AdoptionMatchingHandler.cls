public with sharing class AdoptionMatchingHandler {
    public static parent__c[] matchChildren(Child__c[] children) {
        parent__c[] parents;
        for(Child__c child : children) {
            string query = 'SELECT Id, Email__c FROM parent__c ' +
                'WHERE Trampoline__c = :child.Trampoline__c ' +
                'AND Ice_Cream__c INCLUDES (\'' + iceCreams(child.Ice_Cream__c) + '\') ' +
                'AND Siblings__c >= :child.min_siblings__c ' +
                'AND Siblings__c <= :child.max_siblings__c ' +
                'AND Bedtime__c >= :child.bedtime';
            parents = database.query(query);
        }
        return parents;
    }

    public static string iceCreams(string flavors) {
        string[] allFlavors = flavors.split(';');
        return string.join(allFlavors, '\',\'');
    }
}
// Don't query in a loop