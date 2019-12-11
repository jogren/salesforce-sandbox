trigger Contacts on Contact (after insert, after update, after delete, after undelete) {
  if(trigger.isbefore) {

  } else if (trigger.isAfter) {
    if (trigger.isinsert) {
      ContactHandler.setContactCountOnNonUpdate(trigger.new);
    } else if (trigger.isUpdate) {
      ContactHandler.setContactCountOnUpdate(trigger.oldmap, trigger.newmap);
    } else if (trigger.isDelete) {
      ContactHandler.setContactCountOnNonUpdate(trigger.old);
    } else if (trigger.isUndelete) {
      ContactHandler.setContactCountOnNonUpdate(trigger.new);
    }
  }
}