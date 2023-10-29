<#macro
  kw
  autofocus=false
  checked=false
  disabled=false
  id=""
  invalid=false
  label=""
  name=""
  required=false
  rest...
>
  <div class="flex items-center">
    <input
      <#if autofocus>autofocus</#if>
      <#if disabled>disabled</#if>
      <#if required>required</#if>
      <#if checked>checked</#if>

      aria-invalid="${invalid?c}"
      class="border-secondary-200 h-4 rounded text-primary-600 w-4 focus:ring-primary-200 focus:ring-opacity-50"
      id="<#if id=="">${name}<#else>${id}</#if>"
      name="${name}"
      type="checkbox"

      <#list rest as attrName, attrValue>
        <#if attrValue!="">
          ${attrName}="${attrValue}"
        </#if>
      </#list>
    >
    <label class="ml-2 text-secondary-600 text-sm" for="${name}">
      ${label}
    </label>
  </div>
</#macro>
