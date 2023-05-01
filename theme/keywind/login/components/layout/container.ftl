<#import "../icon/safe-logo.ftl" as iconSafeLogo>
  <#macro kw>
    <div class="bg-white min-h-screen w-screen">
      <div class="flex justify-between lg:py-5 lg:px-18 py-2 px-2">
        <div>
          <a class="no-underline hover:no-underline" href="/">
            <@iconSafeLogo.kw />
          </a>
        </div>
        <div>
          <a class="no-underline hover:no-underline" href="/">
            <p class="text-white bg-purple-main tracking-wider px-6 rounded-md py-3">Contact us</p>
          </a>
        </div>
      </div>
      <div class="flex flex-col items-center justify-center mt-20">
        <div class="max-w-md space-y-6 w-full ">
          <#nested>
        </div>
      </div>
    </div>
  </#macro>
