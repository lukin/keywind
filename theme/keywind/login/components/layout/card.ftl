 <#import "../icon/logo.ftl" as iconLogo>
   <#macro kw>
     <div class="bg-white px-2 rounded-lg space-y-6">
       <div class="flex justify-center">
         <@iconLogo.kw />
       </div>
       <#nested>
     </div>
   </#macro>
