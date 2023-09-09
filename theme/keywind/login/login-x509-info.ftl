<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("doLogIn")}
    <#elseif section = "form">
        <#if x509.formData.isUserEnabled??>
            <div class="flex flex-col items-center space-y-2 w-full">
                ${msg("doX509Login")}
                <span class="text-xl font-bold">${(x509.formData.username!'')}</span>
            </div>
        </#if>

        <div class="flex flex-col w-full text-sm">
            ${msg("clientCertificate")}
            <span class="overflow-scroll w-full pb-2 text-secondary-600">
                <#if x509.formData.subjectDN??>
                    ${(x509.formData.subjectDN!"")}
                <#else>
                    ${msg("noCertificate")}
                </#if>
            </span>
        </div>

        <@form.kw id="kc-x509-login-info" action=url.loginAction method="post">
            <@buttonGroup.kw>
                <@button.kw color="primary" name="login" type="submit">
                    ${msg("doContinue")}
                </@button.kw>
                <#if x509.formData.isUserEnabled??>
                    <@button.kw color="secondary" name="cancel" type="submit">
                        ${msg("doIgnore")}
                    </@button.kw>
                </#if>
            </@buttonGroup.kw>
        </@form.kw>
    </#if>
</@layout.registrationLayout>
