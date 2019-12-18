@isTest public class Adoption_test {
    @isTest static void testClassVariables() {
        Adoption controller = new Adoption();
        // system.assert(expected, actual);
        system.assertEquals('initial', controller.state);
        system.assertEquals(null, controller.parent);
        system.assertEquals(null, controller.child);
        system.assertEquals(null, controller.meridiem);
        system.assertEquals('AM', controller.meridiemOptions[0].getLabel());
        system.assertEquals('PM', controller.meridiemOptions[0].getValue());
        system.assertEquals('PM', controller.meridiemOptions[1].getLabel());
        system.assertEquals('AM', controller.meridiemOptions[1].getValue());
        controller.parent = new Parent__c(name = 'Greg');
        system.assertEquals('Greg', controller.customerName);
        controller.child = new Child__c(name = 'Billy');
        system.assertEquals('Billy', controller.customerName);
    }

    @isTest static void testChildEntryButtons() {
        Adoption controller = new Adoption();
        controller.goToChildEntry();
        system.assertNotEquals(null, controller.child);
        system.assertEquals('child entry', controller.state);
    }

    @isTest static void testParentEntryButtons() {
        Adoption controller = new Adoption();
        controller.goToParentEntry();
        system.assertNotEquals(null, controller.parent);
        system.assertEquals('parent entry', controller.state);
    }
}
