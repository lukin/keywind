<#macro kw component="button" rest...>
  <${component}
    class="bg-primary-600 flex justify-center px-4 py-2 relative rounded-lg text-sm text-white w-full focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2 hover:bg-primary-700"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
