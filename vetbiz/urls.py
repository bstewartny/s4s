from django.conf.urls import patterns,url

from vetbiz import views
from vetbiz import api

urlpatterns=patterns('',
        url(r'api/getbiz/$',api.getbiz),
        url(r'api/updatebiz/$',api.updatebiz),
        url(r'api/searchbiz/$',api.searchbiz),
        url(r'api/signin/$',api.signin),
        url(r'api/signup/$',api.signup),
        url(r'api/dologout/$',api.dologout),
        url(r'api/checkin/$',api.checkin),
        url(r'search/$',views.search),
        url(r'search$',views.search),
        url(r'signin/$',views.signin),
        url(r'signin$',views.signin),
        url(r'signup/$',views.signup),
        url(r'signup$',views.signup),
        url(r'/$',views.search),
        url(r'$',views.search))

