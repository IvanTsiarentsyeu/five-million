public with sharing class FiveMillionScheduler implements Schedulable {
    final static Integer TWO_THOUSAND = 2000; // just for testing purposes sometimes 2000 = something else;

    public void execute(SchedulableContext ctx) {
        FiveMillionCounterBatch batchObject = new FiveMillionCounterBatch();
        Id jobId = Database.executeBatch(batchObject, TWO_THOUSAND);
        System.debug('FiveMillionCounterBatch Job Id = ' + jobId);
    }
}

// System.schedule('Daily contacts rating/place update', '00 01 11 * * ?', new FiveMillionScheduler());