public class AuthorizeDotNetResponse {
    public TransactionResponse transactionResponse;
    public ResultMessages messages;
    
    public class TransactionResponse {
        public string responseCode;
        public string authCode;
        public string avsResultCode;
        public string cvvResultCode;
        public string cavvResultCode;
        public string transId;
        public string refTransID;
        public string transHash;
        public string testRequest;
        public string accountNumber;
        public string accountType;
        public Message[] messages;
        public list<Error> errors; 
    }

    public class Message {
        public string code;
        public string description;
        public string text;
    }

    public class Error {
        public string errorCode;
        public string errorText;
    }

    public class ResultMessages {
        public string resultCode;
        public Message[] message;

    }

}
