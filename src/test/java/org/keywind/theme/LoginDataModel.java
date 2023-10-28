package org.keywind.theme;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LoginDataModel {
  public static Map<String, Object> createDataModel() {
    Map<String, Object> dataModel = new HashMap<>();
    dataModel.put("auth", createAuthModel());
    dataModel.put("client", createClientModel());
    dataModel.put("locale", createLocaleModel());
    dataModel.put("login", createLoginModel());
    dataModel.put("logoutConfirm", createLogoutConfirmModel());
    dataModel.put("message", createMessageModel());
    dataModel.put("oauth", createOAuthModel());
    dataModel.put("otpLogin", createOtpLoginModel());
    dataModel.put("properties", createPropertiesModel());
    dataModel.put("realm", createRealmModel());
    dataModel.put("recoveryAuthnCodesConfigBean", createRecoveryAuthnCodesConfigBeanModel());
    dataModel.put("recoveryAuthnCodesInputBean", createRecoveryAuthnCodesInputBeanModel());
    dataModel.put("social", createSocialModel());
    dataModel.put("totp", createTotpModel());
    dataModel.put("url", createUrlModel());
    dataModel.put("user", createUserModel());
    dataModel.put("username", "Username");
    dataModel.put("x509", createX509Model());
    dataModel.putAll(createWebAuthnModel());

    return dataModel;
  }

  private static Map<String, Object> createAuthModel() {
    Map<String, Object> securityKey = new HashMap<>();
    securityKey.put("authExecId", "authExecId");
    securityKey.put("displayName", "Security Key");
    securityKey.put("helpText", "Use your security key to sign in.");

    List<Map<String, Object>> authenticationSelections = new ArrayList<>();
    authenticationSelections.add(securityKey);

    Map<String, Object> auth = new HashMap<>();
    auth.put("attemptedUsername", "Attempted Username");
    auth.put("authenticationSelections", authenticationSelections);
    auth.put("showResetCredentials", new AuthenticationUtil());
    auth.put("showTryAnotherWayLink", new AuthenticationUtil());
    auth.put("showUsername", new AuthenticationUtil());

    return auth;
  }

  private static Map<String, Object> createClientModel() {
    Map<String, Object> attributes = new HashMap<>();

    Map<String, Object> client = new HashMap<>();
    client.put("attributes", attributes);

    return client;
  }

  private static Map<String, Object> createLocaleModel() {
    Map<String, Object> de = new HashMap<>();
    de.put("label", "Deutsch");
    de.put("url", "url");

    Map<String, Object> en = new HashMap<>();
    en.put("label", "English");
    en.put("url", "url");

    Map<String, Object> fr = new HashMap<>();
    fr.put("label", "Français");
    fr.put("url", "url");

    List<Map<String, Object>> supported = new ArrayList<>();
    supported.add(de);
    supported.add(en);
    supported.add(fr);

    Map<String, Object> locale = new HashMap<>();
    locale.put("current", "English");
    locale.put("currentLanguageTag", "en");
    locale.put("supported", supported);

    return locale;
  }

  private static Map<String, Object> createLoginModel() {
    Map<String, Object> login = new HashMap<>();
    login.put("rememberMe", true);

    return login;
  }

  private static Map<String, Object> createLogoutConfirmModel() {
    Map<String, Object> logoutConfirm = new HashMap<>();
    logoutConfirm.put("code", "code");
    logoutConfirm.put("skipLink", false);

    return logoutConfirm;
  }

  private static Map<String, Object> createMessageModel() {
    Map<String, Object> message = new HashMap<>();
    message.put("summary", "Example of an error message");
    message.put("type", "error");

    return message;
  }

  private static Map<String, Object> createOAuthModel() {
    List<Map<String, Object>> clientScopesRequested = new ArrayList<>();

    Map<String, Object> oauth = new HashMap<>();
    oauth.put("clientScopesRequested", clientScopesRequested);
    oauth.put("code", "code");

    return oauth;
  }

  private static Map<String, Object> createOtpLoginModel() {
    List<Map<String, Object>> userOtpCredentials = new ArrayList<>();

    Map<String, Object> otpLogin = new HashMap<>();
    otpLogin.put("selectedCredentialId", 1);
    otpLogin.put("userOtpCredentials", userOtpCredentials);

    return otpLogin;
  }

  private static Map<String, Object> createPropertiesModel() {
    Map<String, Object> properties = new HashMap<>();
    properties.put("scripts", "src/index.ts");
    properties.put("styles", "src/index.css");

    return properties;
  }

  private static Map<String, Object> createRealmModel() {
    Map<String, Object> realm = new HashMap<>();
    realm.put("displayNameHtml", "Keywind");
    realm.put("internationalizationEnabled", true);
    realm.put("loginWithEmailAllowed", true);
    realm.put("password", true);
    realm.put("registrationAllowed", true);
    realm.put("registrationEmailAsUsername", true);
    realm.put("rememberMe", true);
    realm.put("resetPasswordAllowed", true);

    return realm;
  }

  public static Map<String, Object> createRecoveryAuthnCodesConfigBeanModel() {
    List<String> generatedRecoveryAuthnCodesList = new ArrayList<>();
    generatedRecoveryAuthnCodesList.add("000000000000");
    generatedRecoveryAuthnCodesList.add("111111111111");

    Map<String, Object> recoveryAuthnCodesConfigBean = new HashMap<>();
    recoveryAuthnCodesConfigBean.put("generatedAt", "generatedAt");
    recoveryAuthnCodesConfigBean.put("generatedRecoveryAuthnCodesAsString", "generatedRecoveryAuthnCodesAsString");
    recoveryAuthnCodesConfigBean.put("generatedRecoveryAuthnCodesList", generatedRecoveryAuthnCodesList);

    return recoveryAuthnCodesConfigBean;
  }

  public static Map<String, Object> createRecoveryAuthnCodesInputBeanModel() {
    Map<String, Object> recoveryAuthnCodesInputBean = new HashMap<>();
    recoveryAuthnCodesInputBean.put("codeNumber", "codeNumber");

    return recoveryAuthnCodesInputBean;
  }

  private static Map<String, Object> createSocialModel() {
    Map<String, Object> facebook = new HashMap<>();
    facebook.put("alias", "facebook");
    facebook.put("displayName", "Facebook");
    facebook.put("loginUrl", "loginUrl");

    Map<String, Object> github = new HashMap<>();
    github.put("alias", "github");
    github.put("displayName", "GitHub");
    github.put("loginUrl", "loginUrl");

    Map<String, Object> google = new HashMap<>();
    google.put("alias", "google");
    google.put("displayName", "Google");
    google.put("loginUrl", "loginUrl");

    List<Map<String, Object>> providers = new ArrayList<>();
    providers.add(facebook);
    providers.add(github);
    providers.add(google);

    Map<String, Object> social = new HashMap<>();
    social.put("providers", providers);

    return social;
  }

  private static Map<String, Object> createTotpModel() {
    Map<String, Object> otpCredential = new HashMap<>();

    List<Map<String, Object>> otpCredentials = new ArrayList<>();
    otpCredentials.add(otpCredential);

    List<String> supportedApplications = new ArrayList<>();
    supportedApplications.add("totpAppFreeOTPName");

    Map<String, Object> totp = new HashMap<>();
    totp.put("manualUrl", "manualUrl");
    totp.put("otpCredentials", otpCredentials);
    totp.put("supportedApplications", supportedApplications);
    totp.put("totpSecret", "totpSecret");
    totp.put("totpSecretQrCode",
        "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");

    return totp;
  }

  private static Map<String, Object> createUrlModel() {
    Map<String, Object> url = new HashMap<>();
    url.put("loginAction", "loginAction");
    url.put("loginResetCredentialsUrl", "loginResetCredentialsUrl");
    url.put("loginRestartFlowUrl", "loginRestartFlowUrl");
    url.put("loginUrl", "loginUrl");
    url.put("logoutConfirmAction", "logoutConfirmAction");
    url.put("oauthAction", "oauthAction");
    url.put("registrationAction", "registrationAction");
    url.put("registrationUrl", "registrationUrl");
    url.put("resourcesPath", "http://localhost:5173");

    return url;
  }

  private static Map<String, Object> createUserModel() {
    Map<String, Object> user = new HashMap<>();
    user.put("editUsernameAllowed", true);

    return user;
  }

  private static Map<String, Object> createWebAuthnModel() {
    Map<String, Object> webAuthn = new HashMap<>();
    webAuthn.put("challenge", "challenge");
    webAuthn.put("execution", "execution");
    webAuthn.put("createTimeout", "60000");
    webAuthn.put("isUserIdentified", "true");
    webAuthn.put("rpId", "https://webauthn.me");
    webAuthn.put("userVerification", "preferred");

    return webAuthn;
  }

  private static Map<String, Object> createX509Model() {
    Map<String, Object> formData = new HashMap<>();
    formData.put("isUserEnabled", "true");
    formData.put("subjectDN", "CN=User, C=US, O=Keywind");
    formData.put("username", "Username");

    Map<String, Object> x509 = new HashMap<>();
    x509.put("formData", formData);

    return x509;
  }
}
