<#import "/assets/icons/chevron-down.ftl" as icon>
<#import "/components/atoms/link.ftl" as link>

<#macro kw currentLocale="" locales=[]>
  <div class="flex justify-center relative min-w-[90px] -mr-[10px]" x-data="{ open: false }">
    <@link.kw @click="open = true" color="secondary" component="button" type="button">
      <div class="flex items-center">
        <span class="mr-1 text-sm">${currentLocale}</span>
        <@icon.kw />
      </div>
    </@link.kw>
    <div class="absolute bg-white bottom-0 left-0 mb-6 overflow-hidden rounded-lg shadow-lg">
      <div
        @click.away="open = false"
        class="max-h-80 overflow-y-auto"
        x-cloak
        x-show="open"
      >
        <#list locales as locale>
          <#if currentLocale != locale.label>
            <div class="px-4 py-2">
              <@link.kw color="secondary" href=locale.url size="small">
                ${locale.label}
              </@link.kw>
            </div>
          </#if>
        </#list>
      </div>
    </div>
  </div>
</#macro>
