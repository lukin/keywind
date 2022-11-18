<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/button/secondary.ftl" as buttonSecondary>

<@layout.registrationLayout displayMessage=true; section>
    <#if section = "header">
        ${kcSanitize(msg("webauthn-error-title"))}
    <#elseif section = "form">

        <script type="text/javascript">
            refreshPage = () => {
                document.getElementById('isSetRetry').value = 'retry';
                document.getElementById('executionValue').value = '${execution}';
                document.getElementById('kc-error-credential-form').submit();
            }
        </script>

        <form id="kc-error-credential-form" action="${url.loginAction}" method="post" class="m-0">
            <input type="hidden" id="executionValue" name="authenticationExecution"/>
            <input type="hidden" id="isSetRetry" name="isSetRetry"/>
        </form>

        <@buttonPrimary.kw type="button" tabindex="4" onclick="refreshPage()">
          ${kcSanitize(msg("doTryAgain"))}
        </@buttonPrimary.kw>

        <#if isAppInitiatedAction??>
            <form action="${url.loginAction}" method="post" class="m-0">
                <@buttonSecondary.kw name="cancel-aia" type="submit" value="true">
                  ${kcSanitize(msg("doCancel"))}
                </@buttonSecondary.kw>
            </form>
        </#if>

    </#if>
</@layout.registrationLayout>
