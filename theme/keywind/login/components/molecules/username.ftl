<#import "/assets/icons/arrow-top-right-on-square.ftl" as icon>
<#import "/components/atoms/link.ftl" as link>

<#macro kw linkHref="" linkTitle="" name="">
  <div class="flex items-center justify-center mb-4 space-x-2">
    <b>${name}</b>
    <@link.kw
      color="primary"
      href=linkHref
      title=linkTitle
    >
      <@icon.kw />
    </@link.kw>
  </div>
</#macro>
