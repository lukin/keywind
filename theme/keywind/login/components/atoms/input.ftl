<#import "/assets/icons/eye.ftl" as iconEye>
<#import "/assets/icons/eye-slash.ftl" as iconEyeSlash>
<#macro
  kw
  autofocus=false
  disabled=false
  id=""
  invalid=false
  label=""
  message=""
  name=""
  required=false
  type="text"
  rest...
>
  <div>
    <label class="sr-only" for="${name}">
      ${label}
    </label>
    <#if type == "password">
      <div class="relative">
        <input
          <#if autofocus>autofocus</#if>
          <#if disabled>disabled</#if>
          <#if required>required</#if>

          aria-invalid="${invalid?c}"
          class="block border-secondary-200 mt-1 pr-8 rounded-md w-full focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 sm:text-sm"
          id="<#if id=="">${name}<#else>${id}</#if>"
          name="${name}"
          placeholder="${label}"
          type="${type}"

          <#list rest as attrName, attrValue>
            <#if attrValue!="">
              ${attrName}="${attrValue}"
            </#if>
          </#list>
        />
        <button class="absolute inset-y-0 right-0 pr-3 flex items-center text-sm leading-5" type="button" aria-label="${msg("showPassword")}"
            aria-controls="${name}" data-password-toggle
            data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
          <@iconEye.kw style="display: block;" />
          <@iconEyeSlash.kw style="display: none;" />
        </button>
      </div>
      <script type="module" src="${url.resourcesPath}/dist/passwordVisibility.js" defer></script>
    <#else>
      <input
        <#if autofocus>autofocus</#if>
        <#if disabled>disabled</#if>
        <#if required>required</#if>

        aria-invalid="${invalid?c}"
        class="block border-secondary-200 mt-1 rounded-md w-full focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 sm:text-sm"
        id="${name}"
        name="${name}"
        placeholder="${label}"
        type="${type}"

        <#list rest as attrName, attrValue>
          ${attrName}="${attrValue}"
        </#list>
      >
    </#if>
    <#if invalid?? && message??>
      <div class="mt-2 text-red-600 text-sm">
        ${message?no_esc}
      </div>
    </#if>
  </div>
</#macro>
