<#macro kw>
  <body class="bg-secondary-100 flex min-h-screen gap-[2rem]">
    <div class="min-h-screen bg-white hidden md:block">
      <div class="h-full w-[30.75rem] bg-cover bg-no-repeat bg-[url('https://voicify-assets.s3.amazonaws.com/login-bg.svg')]"></div>
    </div>
    <div class="flex min-h-screen flex flex-col items-center justify-center py-16 md:py-[0] flex-1">
      <#nested>
    </div>
  </body>
</#macro>
