package rs.ac.uns.ftn.transport.service;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import rs.ac.uns.ftn.transport.model.UserActivation;
import rs.ac.uns.ftn.transport.service.interfaces.IMailService;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

@Service
@Log4j2
public class MailService implements IMailService {
  String activationMessage =
    "<p>Hello,</p>"
      + "<p>You can activate your account by clicking on the following link:</p>";


  public void sendMail(String recipientEmail, String token) throws MessagingException, UnsupportedEncodingException {
    String subject = "Password Reset Token";
    String content = "<p>Hello,</p>"
      + "<p>You have requested to reset your password.</p>"
      + "<p>This is the token you need to reset your password:</p>"
      + token + "<br>"
      + "<p>Ignore this email if you remember your password, "
      + "or if you did not make this request.</p>";
    sendMail("contact@reborn.vn", "ksdhrtrdwvxhtekw", recipientEmail, subject, content);


  }

  @Override
  public void sendActivationEmail(String recipientEmail, UserActivation activation) throws MessagingException, UnsupportedEncodingException {

    String subject = "Account Activation";

    String activationLink = "http://localhost:8080/api/passenger/activate/" + activation.getId();
    String body = this.activationMessage +
      "<a href='" + activationLink + "'>" + activationLink;
    sendMail("contact@reborn.vn", "ksdhrtrdwvxhtekw", recipientEmail, subject, body);
  }

  private void sendMail(String sender, String password, String receiver, String subject, String body) throws MessagingException, UnsupportedEncodingException {
    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "465");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.starttls.required", "true");
    props.put("mail.smtp.ssl.protocols", "TLSv1.2");
    props.put("mail.smtp.ssl.enable", "true");
    props.put("mail.smtp.quitwait", "false");
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.debug", "true");
    Session session = Session.getInstance(props, new Authenticator() {
      @Override
      protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(sender, password);
      }
    });
    MimeMessage message = new MimeMessage(session);
    Multipart multipart = new MimeMultipart(); //1
    BodyPart bodyPart = new MimeBodyPart();
    bodyPart.setText(body);
    multipart.addBodyPart(bodyPart);
    message.setFrom(new InternetAddress(sender, sender));
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver));
    message.setContent(multipart);
    message.setSubject(subject);
    log.info("Before send email to {}", receiver);
    Transport.send(message);
    log.info("Send email to {} done", receiver);
  }
}
