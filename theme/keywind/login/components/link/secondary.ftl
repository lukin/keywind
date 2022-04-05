<#macro kw component="a" rest...>
  <${component}
    class="flex text-secondary-600 focus:outline-none focus:ring-2 focus:ring-secondary-600 focus:ring-offset-2 hover:text-secondary-900"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
