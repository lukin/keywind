<#macro kw tabIndex id checked=false rest...>
  <input
    <#if checked>checked</#if>
    class="focus:ring-primary-500 h-4 w-4 text-primary-600 border-gray-300"
    type="radio"
    id="${id}"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
  <label
    class="ml-1 text-sm font-medium mr-4"
    for="${id}"
    tabindex="${tabIndex}"
  >
    <#nested>
  </label>
</#macro>
