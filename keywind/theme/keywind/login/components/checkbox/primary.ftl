<#macro kw name checked=false rest...>
  <div class="flex items-center">
    <input
      <#if checked>checked</#if>
      class="border-gray-300 h-4 rounded text-primary-600 w-4 focus:ring-primary-200 focus:ring-opacity-50"
      id="${name}"
      name="${name}"
      type="checkbox"
      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="block ml-2 text-gray-900 text-sm" for="${name}">
      <#nested>
    </label>
  </div>
</#macro>
