<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout
  displayMessage=messagesPerField.exists('global')
  displayRequiredFields=false;
  section
>
  <#if section="header">
    ${msg("loginIdpReviewProfileTitle")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">

      <@input.kw
        autocomplete="email"
        invalid=messagesPerField.existsError("email")
        label=msg("email")
        message=kcSanitize(messagesPerField.get("email"))
        name="email"
        type="email"
        value=(user.getEmail())!''
      />
      <@input.kw
        autocomplete="given-name"
        autofocus=true
        invalid=messagesPerField.existsError("firstName")
        label=msg("firstName")
        message=kcSanitize(messagesPerField.get("firstName"))
        name="firstName"
        type="text"
        value=(user.getFirstName())!''
      />
      <@input.kw
        autocomplete="family-name"
        invalid=messagesPerField.existsError("lastName")
        label=msg("lastName")
        message=kcSanitize(messagesPerField.get("lastName"))
        name="lastName"
        type="text"
        value=(user.getLastName())!''
      />
      <#if !realm.registrationEmailAsUsername>
        <@input.kw
          autocomplete="username"
          invalid=messagesPerField.existsError("username")
          label=msg("username")
          message=kcSanitize(messagesPerField.get("username"))
          name="username"
          type="text"
          value=(user.getUsername())!''
        />
      </#if>

      <div class="${properties.kcFormGroupClass!}">
        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
          <div class="${properties.kcFormOptionsWrapperClass!}">
          </div>
        </div>

        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
          <@button.kw color="primary" type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}">
            ${msg("doSubmit")}
          </@button.kw>
        </div>
      </div>
    </@form.kw>
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
