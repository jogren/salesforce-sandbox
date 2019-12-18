public with sharing class AuthorizeDotNetController {
    public string amount{get;set;}
    public string ccNumber{get;set;}
    public string expirationMonth{get;set;}
    public string expirationYear{get;set;}
    public string ccv{get;set;}
    public string firstName{get;set;}
    public string lastName{get;set;}
    public string email{get;set;}
    public string street{get;set;}
    public string zip{get;set;}
    public string childId{get;set;}
    public AuthorizeDotNetResponse authDotNetResponse{get;set;}

    public AuthorizeDotNetController() {
    
    }
    public void submitPayment() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        string jsonData = jsonForAuthDotNet();
        request.setMethod('POST');
        request.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(jsonData);
        HttpResponse response = http.send(request);
        string responseJSON = response.getBody();
        responseJSON = responseJSON.substring(1);
        authDotNetResponse = (AuthorizeDotNetResponse)Json.deserialize(responseJSON, AuthorizeDotNetResponse.class);
        if(authDotNetResponse.transactionResponse.responseCode == '1') {
            update new Child__c (id = childId, transaction_id__c = authDotNetResponse.transactionResponse.transId);
        }
    }

    public string jsonForAuthDotNet() {
        boolean not_production = true;
        if (not_production) {
            email = 'jogren0044@gmail.com';
        }
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('createTransactionRequest');
        gen.writeStartObject();
            gen.writeFieldName('merchantAuthentication');
            gen.writeStartObject();
                gen.writeStringField('name', '64dqyBY3p');
                gen.writeStringField('transactionKey', '9jEJz76B9bzE7K4u');
            gen.writeEndObject();
            gen.writeFieldName('transactionRequest');
            gen.writeStartObject();
                gen.writeStringField('transactionType', 'authCaptureTransaction');
                gen.writeStringField('amount', amount);
                gen.writeFieldName('payment');
                gen.writeStartObject();
                    gen.writeFieldName('creditCard');
                    gen.writeStartObject();
                    gen.writeStringField('cardNumber', ccNumber);
                    gen.writeStringField('expirationDate', expirationMonth + expirationYear);
                    gen.writeStringField('cardCode', ccv);
                    gen.writeEndObject();
                gen.writeEndObject();
                gen.writeFieldName('order');
                gen.writeStartObject();
                    gen.writeStringField('invoiceNumber', '123');
                    gen.writeStringField('description', 'description');
                gen.writeEndObject();
                gen.writeFieldName('customer');
                gen.writeStartObject();
                    gen.writeStringField('email', email);
                gen.writeEndObject();
                gen.writeFieldName('billTo');
                gen.writeStartObject();
                    gen.writeStringField('firstName', firstName);
                    gen.writeStringField('lastName', lastName);
                    gen.writeStringField('address', street);
                    gen.writeStringField('zip', zip);
                gen.writeEndObject();
                gen.writeFieldName('transactionSettings');
                gen.writeStartObject();
                    gen.writeFieldname('setting');
                    gen.writeStartObject();
                    gen.writeStringField('settingName', 'emailCustomer');
                    gen.writeStringField('settingValue', '1');
                    gen.writeEndObject();
                gen.writeEndObject();
            gen.writeEndObject();
        gen.writeEndObject();
        gen.writeEndObject();
        // This output contains a credit card number, so we shouldn't log it in production where real details are used.
        if (not_production) {
        System.debug('*** JSON output ***');
        System.debug(gen.getAsString());
        }
        return gen.getAsString();
    }
}
