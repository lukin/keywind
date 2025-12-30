<#macro kw script="">
  <title>${msg("loginTitle", (realm.displayName!""))}</title>

  <meta charset="utf-8">
  <meta name="robots" content="noindex, nofollow">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <script>
    // Dark mode detection - runs immediately to prevent flash
    (function() {
      const htmlElement = document.documentElement;
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      
      // Only add class if Keycloak hasn't already set it
      if (!htmlElement.classList.contains('dark') && !htmlElement.classList.contains('light')) {
        if (prefersDark) {
          htmlElement.classList.add('dark');
        } else {
          htmlElement.classList.add('light');
        }
      }
    })();
  </script>

  <#if properties.meta?has_content>
    <#list properties.meta?split(" ") as meta>
      <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}">
    </#list>
  </#if>

  <#if properties.favicons?has_content>
    <#list properties.favicons?split(" ") as favicon>
      <link href="${url.resourcesPath}/${favicon?split('==')[0]}" rel="${favicon?split('==')[1]}">
    </#list>
  </#if>

  <#if properties.styles?has_content>
    <#list properties.styles?split(" ") as style>
      <link href="${url.resourcesPath}/${style}" rel="stylesheet">
    </#list>
  </#if>

  <#if script?has_content>
    <script defer src="${url.resourcesPath}/${script}" type="module"></script>
  </#if>

  <#if properties.scripts?has_content>
    <#list properties.scripts?split(" ") as script>
      <script defer src="${url.resourcesPath}/${script}" type="module"></script>
    </#list>
  </#if>
</#macro>
