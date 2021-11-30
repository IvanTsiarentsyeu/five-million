public with sharing class FiveMillionCreatorBatch implements Database.Batchable<SObject> {
    private final String ACCOUNT_PREFIX = '5_MILLION';
    private final String CONTACT_PREFIX = 'XZ';
    private Integer contactCount;

    public FiveMillionCreatorBatch (Integer accountCount, Integer contactCount) {
        this.contactCount = contactCount;
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i < accountCount; i++) {
            Account newAccount = new Account();
            newAccount.Name = ACCOUNT_PREFIX + ' ' + String.valueOf(i);
            accounts.add(newAccount);
        }
        insert accounts;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String searchString = ACCOUNT_PREFIX + '%';
        return Database.getQueryLocator('SELECT Id, Name From Account WHERE Name LIKE :searchString');
    }

    public void execute(Database.BatchableContext bc, List<Account> accounts){
        List<Contact> contacts = new List<Contact>(); 
        for (Account a : accounts){
            for (Integer i=0; i < this.contactCount; i++) {
                Contact contact = new Contact();
                contact.lastName = makeName(CONTACT_PREFIX);
                contact.AccountId = a.Id;
                contact.Rating__c = (Math.random()*101).intValue();
                contacts.add(contact);
            }
        }
        insert contacts;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('It is over');
    }


    private String makeName(String prefix) {

        Map<Integer, List<String>> wordsMap = new Map<Integer, List<String>> {
            0 => new List<String> {'Some ', 'Few ', 'Two ', 'Fiwe ', 'Ten ', 'Six ', 'Four ', 'Nine ', 'All ', 'Many '},
            1 => new List<String> {'nice ', 'funny ', 'good ', 'bad ', 'crapy ', 'weird ', 'great ', 'easy ', 'sweet ', 'poor '},
            2 => new List<String> {'big ', 'small ', 'tall ', 'long ', 'tiny ', 'huge ', 'giant ', 'little ', 'jumbo ', 'large ' },
            3 => new List<String> {'wide ', 'flat ', 'round ', 'oval ', 'sqare ', 'curved ', '', 'hollow ', 'wide ', 'blobby '},
            4 => new List<String> {'old ', 'young ', 'eldery ', 'aged ', 'ageless ', 'unyoung ', 'preteen ', '', '', ''},
            5 => new List<String> {'black ', 'blue ', 'red ', 'yellow ', 'white ', 'orange ', 'green ', 'violet ', 'grey ', 'pink '},
            6 => new List<String> {'French ', 'German ', 'Brittish ', 'Russian ', 'Iranian ', 'Austrian ', 'Cuban ', 'Indian ', 'Chinese ', 'Martian '},
            7 => new List<String> {'metal ', 'wooden ', 'plastic ', 'rubber ', 'cotton ', 'stone ', 'ceramic ', 'wool ', 'copper ', 'uranium '},
            8 => new List<String> {'U-shaped ', 'X-winged ', 'four-sided ', 'dog-like ', 'O-shaped ', 'Z-winged ', 'cursed ', 'cat-like ', 'A-shaped ', 'one-sided'},
            9 => new List<String> {'rocks', 'girls', 'boys', 'men', 'whales', 'dogs', 'cars', 'zebras', 'cats', 'fishes'}
        };

        String computedName = prefix + ' ';
        for (Integer k=0; k <= 9; k++) {
            computedName = computedName + wordsMap.get(k)[Integer.valueOf(Math.random()*9)];
        }
        return  computedName.left(80);
    }
}
