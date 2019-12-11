public with sharing class ContactHandler {
    public static void setContactCountOnNonUpdate(contact[] contacts) {
        set<id> accountIds = accountIdsFromContacts(contacts);
        setContactCount(accountIds);
    }

    private static void setContactCount(set<id> accountIds) {
        aggregateResult[] results = [SELECT count(id) word, accountId FROM contact WHERE accountId IN :accountIds GROUP BY accountId];

        account[] accounts = new account[]{};
        for(aggregateResult result :results) {
            account newAccount = new account(id = (id)result.get('accountId'), Contact_Count__c = (integer)result.get('word'));
            accounts.add(newAccount);
        }
        update accounts;
    }

    private static set<id> accountIdsFromContacts(contact[] contacts) {
        set<id> accountIds = new set<id>();
        for(contact contact :contacts) {
            accountIds.add(contact.accountId);
        }
        return accountIds;
    }

    public static void setContactCountOnUpdate(map<id,contact> oldContactByContactId, map<id,contact> newContactByContactId) {
        set<id> accountIds = new set<id>();
        for(id contactId: oldContactByContactId.keySet()) {
            contact oldContact = oldContactByContactId.get(contactId);
            contact newContact = newContactByContactId.get(contactId);
            if(oldContact.accountId != newContact.accountId) {
                accountIds.add(oldContact.accountId);
                accountIds.add(newContact.accountId);
            }
        }
        setContactCount(accountIds);
    }
}
