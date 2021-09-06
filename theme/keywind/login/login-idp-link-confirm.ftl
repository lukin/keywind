<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("confirmLinkIdpTitle")}
    <#elseif section = "form">
        <form action="${url.loginAction}" method="post" class="m-0 space-y-4">
            <div>
                <@buttonPrimary.kw type="submit" name="submitAction" id="updateProfile" value="updateProfile">
                    ${msg("confirmLinkIdpReviewProfile")}
                </@buttonPrimary.kw>
            </div>
            <div>
                <@buttonPrimary.kw type="submit" name="submitAction" id="linkAccount" value="linkAccount">
                    ${msg("confirmLinkIdpContinue", idpDisplayName)}
                </@buttonPrimary.kw>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
