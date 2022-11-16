<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/button/secondary.ftl" as buttonSecondary>

<@layout.registrationLayout; section>
    <#if section="header">
        <#if client.attributes.logoUri??>
            <img class="mb-2" src="${client.attributes.logoUri}"/>
        </#if>
        <p>
        <#if client.name?has_content>
            ${msg("oauthGrantTitle",advancedMsg(client.name))}
        <#else>
            ${msg("oauthGrantTitle",client.clientId)}
        </#if>
        </p>
    <#elseif section="form">
        <h3>${msg("oauthGrantRequest")}</h3>
        <ul class="list-disc ml-4">
            <#if oauth.clientScopesRequested??>
                <#list oauth.clientScopesRequested as clientScope>
                    <li>
                        <#if !clientScope.dynamicScopeParameter??>
                            ${advancedMsg(clientScope.consentScreenText)}
                        <#else>
                            ${advancedMsg(clientScope.consentScreenText)}: <b>${clientScope.dynamicScopeParameter}</b>
                        </#if>
                    </li>
                </#list>
            </#if>
        </ul>
        <#if client.attributes.policyUri?? || client.attributes.tosUri??>
            <h3>
                <#if client.name?has_content>
                    ${msg("oauthGrantInformation",advancedMsg(client.name))}
                <#else>
                    ${msg("oauthGrantInformation",client.clientId)}
                </#if>
                <#if client.attributes.tosUri??>
                    ${msg("oauthGrantReview")}
                    <a href="${client.attributes.tosUri}" target="_blank">${msg("oauthGrantTos")}</a>
                </#if>
                <#if client.attributes.policyUri??>
                    ${msg("oauthGrantReview")}
                    <a href="${client.attributes.policyUri}" target="_blank">${msg("oauthGrantPolicy")}</a>
                </#if>
            </h3>
        </#if>

        <form action="${url.oauthAction}" class="m-0 space-y-4" method="POST">
            <input type="hidden" name="code" value="${oauth.code}">

            <div class="flex flex-col pt-4 space-y-2">
              <@buttonPrimary.kw type="submit" name="accept">
                ${msg("doYes")}
              </@buttonPrimary.kw>

              <@buttonSecondary.kw type="submit" name="cancel">
                ${msg("doNo")}
              </@buttonSecondary.kw>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
