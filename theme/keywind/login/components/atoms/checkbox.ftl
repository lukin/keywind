<#macro kw checked=false label="" name="" rest...>
  <div class="flex items-center">
    <input
      <#if checked>checked</#if>

      class="border-secondary-200 dark:border-gray-600 h-4 rounded text-primary-600 dark:text-primary-400 w-4 focus:ring-primary-200 dark:focus:ring-primary-800 focus:ring-opacity-50"
      id="${name}"
      name="${name}"
      type="checkbox"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="ml-2 text-secondary-600 dark:text-gray-300 text-sm" for="${name}">
      ${label}
    </label>
  </div>
</#macro>
