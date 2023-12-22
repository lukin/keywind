<#macro kw>
  <#if properties.topLeftLogoUrl??>
    <img src="${properties.topLeftLogoUrl}" class="fixed z-10 top-4 left-8">
  </#if>
  <#if properties.backgroundImageUrl??>
    <img src="${properties.backgroundImageUrl}" class="fixed top-0 left-0 right-0 bottom-0 min-h-full min-w-full opacity-20" style="max-width: none !important;">
  </#if>
  <#if properties.backgroundVideoUrl??>
    <video autoplay loop muted playsinline class="fixed top-0 left-0 right-0 bottom-0 min-h-full min-w-full opacity-20" style="max-width: none !important;">
      <source src="${properties.backgroundVideoUrl}" type="${properties.backgroundVideoType!''}" />
    </video>
  </#if>
</#macro>
