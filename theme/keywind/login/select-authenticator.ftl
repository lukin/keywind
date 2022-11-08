<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "header">
        ${kcSanitize(msg("loginChooseAuthenticator-registration-title"))}
    <#elseif section = "form">

        <script type="text/javascript">
            function fillAndSubmit(authExecId) {
                document.getElementById('authexec-hidden-input').value = authExecId;
                document.getElementById('kc-select-credential-form').submit();
            }
        </script>

        <form id="kc-select-credential-form" action="${url.loginAction}" class="m-0 space-y-4" method="post">
            <div class="flex flex-col space-y-4">
                <#list auth.authenticationSelections as authenticationSelection>
                    <div class="px-4 py-2 relative rounded-lg cursor-pointer hover:bg-primary-50" onclick="fillAndSubmit('${authenticationSelection.authExecId}')">
                        <p class="font-bold text-lg">${msg('${authenticationSelection.displayName}')}</p>
                        <p>${msg('${authenticationSelection.helpText}')}</p>
                    </div>
                </#list>
            </div>
            <input type="hidden" id="authexec-hidden-input" name="authenticationExecution" />
        </form>

    </#if>
</@layout.registrationLayout>

