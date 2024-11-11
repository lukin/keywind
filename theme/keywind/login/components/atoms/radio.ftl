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
  <div>
    <input
      <#if autofocus>autofocus</#if>
      <#if disabled>disabled</#if>
      <#if required>required</#if>
      <#if checked>checked</#if>

      aria-invalid="${invalid?c}"
      class="border-secondary-200 focus:ring-primary-600"
      id="<#if id=="">${name}<#else>${id}</#if>"
      name="${name}"
      type="radio"

      <#list rest as attrName, attrValue>
        <#if attrValue!="">
          ${attrName}="${attrValue}"
        </#if>
      </#list>
    >
    <label class="ml-2 text-secondary-600 text-sm" for="${id}">
      ${label}
    </label>
  </div>
</#macro>
