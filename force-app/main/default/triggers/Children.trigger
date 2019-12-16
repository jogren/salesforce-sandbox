trigger Children on Child__c (after insert) {
  if(Trigger.isAfter) {
    if(Trigger.isInsert) {
      AdoptionMatchingHandler.matchChildren(Trigger.new);
    }
  }
}