<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "components/molecules/recaptcha.ftl" as recaptcha>
<#import "components/molecules/register-commons.ftl" as registerCommons>
<#import "components/molecules/user-profile-commons.ftl" as userProfileCommons>

<@layout.registrationLayout
  displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section
>
  <#if section="header">
    <#if messageHeader??>
      ${kcSanitize(msg("${messageHeader}"))?no_esc}
    <#else>
      ${msg("registerTitle")}
    </#if>
    <#elseif section="form">
    <@form.kw action=url.registrationAction method="post">
      <@userProfileCommons.userProfileFormFields; callback, attribute>
        <#if callback = "afterField">
          <#if passwordRequired?? && (attribute.name = 'username' || (attribute.name = 'email' && realm.registrationEmailAsUsername))>
            <@input.kw
              name="password"
              type="password"
              autocomplete="new-password"
              invalid=messagesPerField.existsError("password")
              label=msg("password") + " *"
              message=kcSanitize(messagesPerField.get("password"))
              required=true
            />
            <#if messagesPerField.existsError('password')>
              <span>${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
            </#if>
            <@input.kw
              name="password-confirm"
              type="password"
              autocomplete="new-password"
              invalid=messagesPerField.existsError("password-confirm")
              label=msg("passwordConfirm") + " *"
              message=kcSanitize(messagesPerField.get("password-confirm"))
              required=true
            />
            <#if messagesPerField.existsError('password-confirm')>
              <span>${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
            </#if>
          </#if>
        </#if>
      </@userProfileCommons.userProfileFormFields>

      <@registerCommons.termsAcceptance/>

      <@recaptcha.kw recaptchaRequired=recaptchaRequired?? recaptchaSiteKey=recaptchaSiteKey />

      <@buttonGroup.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doRegister")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
