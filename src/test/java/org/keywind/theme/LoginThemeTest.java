package org.keywind.theme;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;

import freemarker.core.HTMLOutputFormat;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModelException;
import freemarker.template.TemplateNotFoundException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.jupiter.api.Test;
import org.keycloak.forms.login.LoginFormsPages;
import org.keycloak.forms.login.freemarker.Templates;
import org.keycloak.theme.KeycloakSanitizerMethod;
import org.keycloak.theme.beans.MessageFormatterMethod;
import org.keycloak.theme.beans.MessagesPerFieldBean;

public class LoginThemeTest {
  private static final String LANGUAGE = "English";
  private static final String MESSAGE_PATH = "theme/base/login/messages/messages";
  private static final String OUTPUT_PATH = "html/login";
  private static final String THEME_PATH = "theme/keywind/login";

  @Test
  public void shouldTestTemplates() throws IOException, TemplateException {
    Configuration configuration = createFreeMarkerConfiguration();

    for (String templateName : getTemplateNames()) {
      try {
        Template template = configuration.getTemplate(templateName);
        String renderedTemplate = renderTemplate(template);
        Document document = formatHtml(renderedTemplate);

        saveHtmlToFile(templateName, document);
      } catch (TemplateNotFoundException e) {
        System.out.println("Template not found: " + templateName);
      }
    }
  }

  private Configuration createFreeMarkerConfiguration() throws IOException, TemplateModelException {
    Configuration configuration = new Configuration(Configuration.VERSION_2_3_32);
    configuration.setDirectoryForTemplateLoading(new File(THEME_PATH));
    configuration.setOutputFormat(HTMLOutputFormat.INSTANCE);

    Locale locale = Locale.of(LANGUAGE);
    Properties messages = loadMessages(locale);

    configuration.setSharedVariable("kcSanitize", new KeycloakSanitizerMethod());
    configuration.setSharedVariable("messagesPerField", new MessagesPerFieldBean());
    configuration.setSharedVariable("msg", new MessageFormatterMethod(locale, messages));

    return configuration;
  }

  private Properties loadMessages(Locale locale) {
    ResourceBundle resourceBundle = ResourceBundle.getBundle(MESSAGE_PATH, locale);
    Properties properties = new Properties();

    Enumeration<String> keys = resourceBundle.getKeys();
    while (keys.hasMoreElements()) {
      String key = keys.nextElement();
      String value = resourceBundle.getString(key);

      properties.setProperty(key, value);
    }

    return properties;
  }

  private String[] getTemplateNames() {
    return Arrays.stream(LoginFormsPages.values())
        .map(Templates::getTemplate)
        .toArray(String[]::new);
  }

  private String renderTemplate(Template template) throws IOException, TemplateException {
    Map<String, Object> dataModel = LoginDataModel.createDataModel();

    try (StringWriter writer = new StringWriter()) {
      template.process(dataModel, writer);

      return writer.toString();
    }
  }

  private Document formatHtml(String html) {
    Document document = Jsoup.parse(html);
    document.outputSettings().indentAmount(2);

    return document;
  }

  private void saveHtmlToFile(String templateName, Document document) throws IOException {
    File outputFile = new File(OUTPUT_PATH, templateName.replace(".ftl", ".html"));

    try (FileWriter fileWriter = new FileWriter(outputFile)) {
      fileWriter.write(document.outerHtml());
    }
  }
}
