<#macro kw checked=false id="" label="" rest...>
  <div>
    <input
      <#if checked>checked</#if>

      class="border-secondary-200 dark:border-gray-600 focus:ring-primary-600 dark:focus:ring-primary-400"
      id="${id}"
      type="radio"

      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    <label class="ml-2 text-secondary-600 dark:text-gray-300 text-sm" for="${id}">
      ${label}
    </label>
  </div>
</#macro>
