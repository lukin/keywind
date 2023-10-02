<#macro kw
  autofocus=false
  disabled=false
  id=""
  invalid=false
  label=""
  message=""
  name=""
  required=false
  rest...
>
  <div>
    <label class="sr-only" for="${name}">
      ${label}
    </label>
    <textarea
      <#if autofocus>autofocus</#if>
      <#if disabled>disabled</#if>
      <#if required>required</#if>

      aria-invalid="${invalid?c}"
      class="block border-secondary-200 mt-1 rounded-md w-full focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 sm:text-sm"
      id="<#if id=="">${name}<#else>${id}</#if>"
      name="${name}"
      placeholder="${label}"

      <#list rest as attrName, attrValue>
        <#if attrValue!="">
          ${attrName}="${attrValue}"
        </#if>
      </#list>
    ><#compress>
      <#nested />
    </#compress></textarea>
    <#if invalid?? && message??>
      <div class="mt-2 text-red-600 text-sm">
        ${message?no_esc}
      </div>
    </#if>
  </div>
</#macro>
