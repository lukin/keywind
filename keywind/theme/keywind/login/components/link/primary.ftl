<#macro kw component="a" flexclass="flex" rest...>
  <${component}
    class="${flexclass} text-primary-600 hover:text-primary-500"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
