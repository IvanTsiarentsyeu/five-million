public with sharing class FiveMillionCreatorRun {
    public static final Integer DO_NOT_CHANGE = 1;
    public static final Integer CONTACT_COUNT = 10000; // ON DevOrg CONTACT_COUNT = 2 

    // accountCount = 500 
    public static void doIt(Integer accountCount) {

        FiveMillionCreatorBatch batchObject = 
            new FiveMillionCreatorBatch(accountCount, CONTACT_COUNT);

        Id jobId = Database.executeBatch(batchObject, DO_NOT_CHANGE);
        System.debug('FiveMillionCreatorBatch Job Id = ' + jobId);
    }
}
