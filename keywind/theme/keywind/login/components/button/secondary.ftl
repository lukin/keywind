<#macro kw component="button" rest...>
  <${component}
    class="bg-secondary-100 flex justify-center px-4 py-2 relative rounded-lg text-sm text-secondary-600 w-full focus:outline-none focus:ring-2 focus:ring-secondary-600 focus:ring-offset-2 hover:bg-secondary-200 hover:text-secondary-900"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
