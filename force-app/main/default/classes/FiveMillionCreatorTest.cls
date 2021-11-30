@isTest
private class FiveMillionCreatorTest {
    private static final Integer CONTACT_COUNT = 10000; 

    @isTest
    private static void generalTest() {
        Test.startTest();
        FiveMillionCreatorRun.doIt(1);
        Test.stopTest();
    
        List<Contact> contacts = [SELECT Id, Rating__c FROM Contact];
        Integer recordCount = 0;
        Boolean hasZero = false;
        Boolean hasHundred = false;
        Boolean hasInBetween = false;
        For(Contact c : contacts) {
            recordCount++; 
            System.assert(c.Rating__c >= 0 && c.Rating__c <= 100, 'Rating__c out of range');
            if(c.Rating__c == 0) {
                hasZero = true;
            }
            if(c.Rating__c == 100) {
                hasHundred = true;
            }
            if(c.Rating__c >= 0 && c.Rating__c <= 100) {
                hasInBetween = true;
            }
        }
        System.assert(hasInBetween, 'Rating__c is set incorrectly');
        System.assertEquals(CONTACT_COUNT, recordCount, 'Number of records is wrong');

        // Две сомнительные проверки: в редких случаях ошибку будет выдавать нормально работающий метод
        // Так вообще стоит делать?
        System.assert(hasZero, 'No one Rating__c == 0. Maybe it is an error. Please, run the test one more time');
        System.assert(hasHundred, 'No one Rating__c == 100. Maybe it is an error. Please, run the test one more time');


    }
}
