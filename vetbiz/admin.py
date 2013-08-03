from django.contrib import admin
from vetbiz.models import *
from django import forms
from easy_maps.widgets import AddressWithMapWidget
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User


class OfferInline(admin.TabularInline):
    model=Offer
    extra=1

class BusinessAdmin(admin.ModelAdmin):
    search_fields=['name']
    list_display=('name','category','veteran_owned','veteran_discounts','num_checkins','num_offers','num_redemptions')
    list_filter=['category','veteran_owned','veteran_discounts']
    inlines=[OfferInline]
    
    class form(forms.ModelForm):
        class Meta:
            widgets={
                'address':AddressWithMapWidget({'class':'vTextField'})        
                    
            }

class CategoryAdmin(admin.ModelAdmin):
    search_fields=['name']

class CheckinInline(admin.TabularInline):
    model=Checkin
    extra=1

class RedemptionInline(admin.TabularInline):
    model=Redemption
    extra=1

class VetUserInline(admin.StackedInline):
    model=VetUser
    can_delete=False
    verbose_name_plural='user'

class UserAdmin(UserAdmin):
    inlines=(VetUserInline,)

class CheckinsAdmin(admin.ModelAdmin):
    search_fields=['business__name']
    list_display=('user','business','date')
    list_filter=['date','business__category','business__veteran_owned','business__veteran_discounts','user__veteran']

class OffersAdmin(admin.ModelAdmin):
    search_fields=['title','description']
    list_display=('business','title','start_date','end_date','points','veterans_only','num_redemptions')
    list_filter=['business__category','business__veteran_owned','business__veteran_discounts','veterans_only']
    inlines=[RedemptionInline]

class RedemptionsAdmin(admin.ModelAdmin):
    search_fields=['offer__title','offer__business__name']
    list_display=('business','offer_title','user','date','offer_points')

admin.site.unregister(User)
admin.site.register(User,UserAdmin)
admin.site.register(Business,BusinessAdmin)
admin.site.register(Category,CategoryAdmin)
admin.site.register(Offer,OffersAdmin)
admin.site.register(Checkin,CheckinsAdmin)
admin.site.register(Redemption,RedemptionsAdmin)


