from django.contrib import admin
from vetbiz.models import *
from django import forms
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User


class OfferInline(admin.TabularInline):
    model=Offer
    extra=1

class JobInline(admin.TabularInline):
    model=Job
    extra=1

class BusinessAdmin(admin.ModelAdmin):
    search_fields=['name','address']
    list_display=('name','address','category','veteran_owned','disabled_veteran','veteran_discounts','num_checkins','num_offers','num_redemptions')
    list_filter=['category','veteran_owned','disabled_veteran','veteran_discounts']
    inlines=[OfferInline,JobInline]
    
class CharityAdmin(admin.ModelAdmin):
    search_fields=['name']
    list_display=('name','donated_points')

class CategoryAdmin(admin.ModelAdmin):
    search_fields=['name']

class CheckinInline(admin.TabularInline):
    model=Checkin
    extra=1

class RedemptionInline(admin.TabularInline):
    model=Redemption
    extra=1

class UserProfileInline(admin.StackedInline):
    model=UserProfile
    can_delete=False
    verbose_name_plural='user'

class MyUserAdmin(UserAdmin):
    inlines=(UserProfileInline,)
    #list_display=('username','last_login','userprofile__checkins','userprofile__points')

class CheckinsAdmin(admin.ModelAdmin):
    search_fields=['business__name']
    list_display=('user','business','date')
    list_filter=['date','business__category','business__veteran_owned','business__veteran_discounts']

class BusinessPageViewsAdmin(admin.ModelAdmin):
    search_fields=['business__name']
    list_display=('user','business','date')
    list_filter=['date','business__category','business__veteran_owned','business__veteran_discounts']

class OffersAdmin(admin.ModelAdmin):
    search_fields=['title','description']
    list_display=('business','title','start_date','end_date','points','veterans_only','num_redemptions')
    list_filter=['business__category','business__veteran_owned','business__veteran_discounts','veterans_only']
    inlines=[RedemptionInline]

class JobsAdmin(admin.ModelAdmin):
    search_fields=['title','description','category']
    list_display=('business','title','category','address')
    list_filter=['business__category','category','business__veteran_owned']

class RedemptionsAdmin(admin.ModelAdmin):
    search_fields=['offer__title','offer__business__name']
    list_display=('business','offer_title','user','date','offer_points')

admin.site.unregister(User)
admin.site.register(User,MyUserAdmin)
admin.site.register(Business,BusinessAdmin)
admin.site.register(Charity,CharityAdmin)
admin.site.register(Category,CategoryAdmin)
admin.site.register(Offer,OffersAdmin)
admin.site.register(Job,JobsAdmin)
admin.site.register(Checkin,CheckinsAdmin)
admin.site.register(BusinessPageView,BusinessPageViewsAdmin)
admin.site.register(Redemption,RedemptionsAdmin)


