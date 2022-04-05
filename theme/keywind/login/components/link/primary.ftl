<#macro kw component="a" rest...>
  <${component}
    class="flex text-primary-600 focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2 hover:text-primary-500"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
