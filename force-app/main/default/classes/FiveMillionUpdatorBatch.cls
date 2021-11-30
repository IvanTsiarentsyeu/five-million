public with sharing class FiveMillionUpdatorBatch implements Database.Batchable<SObject>{
    final Integer LOWEST_RATING = 0;
    final Integer HIGHEST_RATING = 100;
    Map<Integer, String> placesMap;

    public FiveMillionUpdatorBatch(Map<Integer, String> placesMap) {
        this.placesMap = placesMap;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Rating__c, Place__c From Contact');
    }

    public void execute(Database.BatchableContext bc, List<Contact> contacts) {
        for(Contact c : contacts) {
            if (c.Rating__c >= LOWEST_RATING && c.Rating__c <= HIGHEST_RATING) {
                c.Place__c = placesMap.get(c.Rating__c.intValue());
            }
        }
        update contacts;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Contacts updated');
    }
}
