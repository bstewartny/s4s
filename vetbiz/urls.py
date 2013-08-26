from django.conf.urls import patterns,url

from vetbiz import views
from vetbiz import api

urlpatterns=patterns('',
        url(r'api/getbiz/$',api.getbiz),
        url(r'api/updatebiz/$',api.updatebiz),
        url(r'api/searchbiz/$',api.searchbiz),
        url(r'api/signin/$',api.signin),
        url(r'api/unique/$',api.unique),
        url(r'api/signup/$',api.signup),
        url(r'api/dologout/$',api.dologout),
        url(r'api/checkin/$',api.checkin),
        url(r'search/$',views.search),
        url(r'search$',views.search),
        url(r'checkins/$',views.checkins),
        url(r'checkins$',views.checkins),
        url(r'offers/$',views.offers),
        url(r'offers$',views.offers),
        url(r'offer/(?P<offer_id>\d+)',views.offer),
        url(r'job/(?P<job_id>\d+)',views.job),
        url(r'place/(?P<place_id>\d+)',views.place),
        url(r'jobs/$',views.jobs),
        url(r'jobs$',views.jobs),
        url(r'places$',views.places),
        url(r'places/$',views.places),
        url(r'profile$',views.profile),
        url(r'profile/$',views.profile),
        url(r'signin/$',views.signin),
        url(r'signin$',views.signin),
        url(r'signup/$',views.signup),
        url(r'signup$',views.signup),
        url(r'/$',views.search),
        url(r'$',views.search))

