<#macro kw recaptchaRequired=false recaptchaSiteKey="">
  <#if recaptchaRequired??>
    <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
    <script type="text/plain" data-category="google_recaptcha" src="https://www.google.com/recaptcha/api.js" async defer></script>
  </#if>
</#macro>
