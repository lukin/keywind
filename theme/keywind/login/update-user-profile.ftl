<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/molecules/user-profile-commons.ftl" as userProfileCommons>

<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <@form.kw action="${url.loginAction}" method="post">
            <@userProfileCommons.userProfileFormFields/>

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
