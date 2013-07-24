from django.conf.urls import patterns,url

from vetbiz import views
from vetbiz import api

urlpatterns=patterns('',
        url(r'api/getbiz/$',api.getbiz),
        url(r'api/updatebiz/$',api.updatebiz),
        url(r'api/searchbiz/$',api.searchbiz),
        url(r'search/$',views.search),
        url(r'search$',views.search),
        url(r'/$',views.search),
        url(r'$',views.search))

