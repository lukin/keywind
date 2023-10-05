<#macro kw>
  <table cellpadding="0" cellspacing="0" border="0" align="center" class="text-center" style="text-align: center;">
    <tr class="text-center" style="text-align: center;">
      <td align="center" class="text-center" style="text-align: center;">
        <#if (properties.headingLogoUrl!"") != "">
          <img class="h-10" src="${properties.headingLogoUrl}" alt="logo" style="height: 40px;">
        <#else>
          <h1 class="text-center text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white" style="text-align: center; font-size: 36px; font-weight: 800; line-height: 1; letter-spacing: -0.025em; color: #111827;">
            ${kcSanitize(kcSanitize(realmName!""))}
          </h1>
        </#if>
      </td>
    </tr>
  </table>
</#macro>
