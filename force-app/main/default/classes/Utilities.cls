public class Utilities {
    public static void send_email(String recipient, String body, String subject) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] recipients = new String[] { recipient };
        mail.setToAddresses(recipients);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}