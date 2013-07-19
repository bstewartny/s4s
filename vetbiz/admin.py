from django.contrib import admin
from vetbiz.models import *

class OfferInline(admin.TabularInline):
    model=Offer
    extra=1

class BusinessAdmin(admin.ModelAdmin):
    search_fields=['name']
    list_display=('name','category','veteran_owned','veteran_discounts','num_checkins','num_offers','num_redemptions')
    list_filter=['category','veteran_owned','veteran_discounts']
    inlines=[OfferInline]


class CategoryAdmin(admin.ModelAdmin):
    search_fields=['name']

class CheckinInline(admin.TabularInline):
    model=Checkin
    extra=1

class RedemptionInline(admin.TabularInline):
    model=Redemption
    extra=1


class UserAdmin(admin.ModelAdmin):
    search_fields=['name']
    list_display=('name','veteran','points','checkins','num_redemptions')
    list_filter=['veteran']
    inlines=[CheckinInline,RedemptionInline]

class CheckinsAdmin(admin.ModelAdmin):
    search_fields=['user__name','business__name']
    list_display=('user','business','date')
    list_filter=['date','business__category','business__veteran_owned','business__veteran_discounts','user__veteran']

class OffersAdmin(admin.ModelAdmin):
    search_fields=['title','description']
    list_display=('business','title','start_date','end_date','points','veterans_only','num_redemptions')
    list_filter=['business__category','business__veteran_owned','business__veteran_discounts','veterans_only']
    inlines=[RedemptionInline]

class RedemptionsAdmin(admin.ModelAdmin):
    search_fields=['user__name','offer__title','offer__business__name']
    list_display=('business','offer_title','user_name','date','offer_points')

admin.site.register(User,UserAdmin)
admin.site.register(Business,BusinessAdmin)
admin.site.register(Category,CategoryAdmin)
admin.site.register(Offer,OffersAdmin)
admin.site.register(Checkin,CheckinsAdmin)
admin.site.register(Redemption,RedemptionsAdmin)


