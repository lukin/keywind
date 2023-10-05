<#macro kw recaptchaRequired=false>
  <#if recaptchaRequired??>
    <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
  </#if>
</#macro>
