<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "components/molecules/user-profile-commons.ftl" as userProfileCommons>
<#import "components/molecules/register-commons.ftl" as registerCommons>

<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
  <#if section = "header">
      ${msg("registerTitle")}
  <#elseif section = "form">
    <@form.kw action="${url.registrationAction}" method="post">
      <@userProfileCommons.userProfileFormFields; callback, attribute>
        <#if callback = "afterField">
	        <#-- render password fields just under the username or email (if used as username) -->
	        <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
	          <@input.kw
              autocomplete="new-password"
              invalid=messagesPerField.existsError("password", "password-confirm")
              label=msg("password") + " *"
              message=kcSanitize(messagesPerField.getFirstError("password", "password-confirm"))
              name="password"
              required=true
              type="password"
            />
            <@input.kw
              autocomplete="new-password"
              invalid=messagesPerField.existsError("password-confirm")
              label=msg("passwordConfirm") + " *"
              message=kcSanitize(messagesPerField.get("password-confirm"))
              name="password-confirm"
              required=true
              type="password"
            />
	        </#if>
        </#if>  
      </@userProfileCommons.userProfileFormFields>

      <@registerCommons.termsAcceptance/>
            
      <#if recaptchaRequired??>
        <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
      </#if>

      <@button.kw color="primary" type="submit">
        ${msg("doRegister")}
      </@button.kw>
    </@form.kw>
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>