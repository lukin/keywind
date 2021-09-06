<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <form class="m-0 space-y-4" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                   readonly="readonly" style="display:none;"/>
            <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

            <div>
                <@inputPrimary.kw
                    autocomplete="new-password"
                    invalid=["password", "password-confirm"]
                    message=false
                    autofocus=true
                    name="password-new"
                    type="password"
                >
                    ${msg("passwordNew")}
                </@inputPrimary.kw>
            </div>
            <div>
                <@inputPrimary.kw
                    autocomplete="new-password"
                    invalid=["password-confirm"]
                    name="password-confirm"
                    type="password"
                >
                    ${msg("passwordConfirm")}
                </@inputPrimary.kw>
            </div>
            <div>
                <@buttonPrimary.kw type="submit">
                    ${msg("doSubmit")}
                </@buttonPrimary.kw>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>