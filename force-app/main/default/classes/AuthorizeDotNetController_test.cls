@isTest public class AuthorizeDotNetController_test {
    // @testSetup static void makeData() {
        // Like a beforeEach() in Jest
    // }

    private static string jsonResponse(string responseCode, string transactionId, string errorText) {
        return '{{"transactionResponse": {"responseCode": "' + responseCode + '", "transId": "' + transactionId + '", "accountType": "Visa", "errors": [{"errorText": "' + errorText + '"}]}}';
    }

    @isTest static void authorizes() {
        Child__c child = new Child__c(Email__c = 'a@b.com');
        insert child;
        string transactionId = '123';
        string response = jsonResponse('1', transactionId, 'error message');
        SingleRequestMock mockResponse = new SingleRequestMock(200, 'complete', response, null);
        Test.setMock(httpCalloutMock.class, mockResponse);
        AuthorizeDotNetController controller = new AuthorizeDotNetController();
        // Test.startTest & Test.stopTest sets governor limits at 0
        Test.startTest();
        controller.amount = '10';
        controller.ccNumber = '4444555566667777';
        controller.expirationMonth = '12';
        controller.expirationYear = '2021';
        controller.ccv = '123';
        controller.firstName = 'Jacob';
        controller.lastName = 'Ogren';
        controller.email = 'jogren0044@gmail.com';
        controller.street = '123 knox avenue south';
        controller.zip = '12345';
        controller.childId = child.id;

        controller.submitPayment();
        Test.stopTest();
        system.assertEquals(transactionId ,[SELECT transaction_id__c FROM child__c WHERE id = :child.id].transaction_id__c);
    }
}
