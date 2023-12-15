<#macro kw>
  <table cellpadding="0" cellspacing="0" border="0" align="center" class="text-center">
    <tr class="text-center">
      <td align="center" class="text-center">
        <#if (properties.headingLogoUrl!"") != "">
          <img class="h-10" src="${properties.headingLogoUrl}" alt="logo" />
        <#else>
          <h1 class="text-center text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
            ${kcSanitize(kcSanitize(realmName!""))}
          </h1>
        </#if>
      </td>
    </tr>
  </table>
</#macro>
