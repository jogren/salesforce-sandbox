public with sharing class Adoption {
    public string state{get;private set;}
    public Parent__c parent{get;set;}
    public Child__c child{get;set;}
    public string meridiem{get;set;}
    public SelectOption[] meridiemOptions {get{
        return new SelectOption[]{
            new SelectOption('AM', 'AM'), 
            new SelectOption('PM', 'PM')
        };
    }}

    public void goToChildEntry() {
        child = new Child__c();
        state = 'child entry';
    }
    public void goToParentEntry() {
        parent = new Parent__c();
        state = 'parent entry';
    }
    public void submitparent() {
        parent.Bedtime__c = fixedBedtime(parent.Bedtime__c);
        insert parent;
        state = 'initial';
    }
    public time fixedBedtime(time bedtime) {
        integer hour = bedtime.hour();
        if (hour == 12 && meridiem == 'AM') {
            return time.newInstance(0, bedtime.minute(), 0, 0);
        } else if (hour < 12 && meridiem == 'PM') {
            return time.newInstance(hour + 12, bedtime.minute(), 0, 0);
        }
        return bedtime;
    }


    public Adoption() {
        state = 'initial';
    }
}