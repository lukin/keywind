<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/molecules/password-commons.ftl" as passwordCommons>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('email'); section>
    <#if section = "header">
        ${msg("updateEmailTitle")}
    <#elseif section = "form">
        <@form.kw action="${url.loginAction}" method="post">
            <@input.kw
              autocomplete="off"
              autofocus=true
              invalid=messagesPerField.existsError("email")
              label=msg("email")
              message=kcSanitize(messagesPerField.get("email"))?no_esc
              name="email"
              required=true
              type="text"
              value=email.value!''
            />

            <@passwordCommons.logoutOtherSessions/>

            <@buttonGroup.kw>
              <#if isAppInitiatedAction??>
                <@button.kw color="primary" type="submit">
                  ${msg("doSubmit")}
                </@button.kw>
                <@button.kw color="secondary" name="cancel-aia" type="submit" value="true">
                  ${msg("doCancel")}
                </@button.kw>
              <#else>
                <@button.kw color="primary" type="submit">
                  ${msg("doSubmit")}
                </@button.kw>
              </#if>
            </@buttonGroup.kw>
        </@form.kw>
    </#if>
</@layout.registrationLayout>
