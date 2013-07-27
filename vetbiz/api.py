from django.http import HttpResponse
from django.shortcuts import render
from django.shortcuts import render_to_response
from django.core import serializers
import json
from vetbiz.models import *
from math import *
from django.views.decorators.csrf import requires_csrf_token
from django.views.decorators.csrf import csrf_exempt

RADIUS=6371 # Earth's mean radius in km

def distance(a,b):
    print "distance: "+str(a)+" to "+str(b)
    (lat1,lon1)=(a[0],a[1])
    (lat2,lon2)=(b[0],b[1])
    dLat=radians(lat1-lat2)
    dLon=radians(lon1-lon2)
    a=sin(dLat/2)*sin(dLat/2)+cos(radians(lat1))*cos(radians(lat2))*sin(dLon/2)*sin(dLon/2)
    c=2*atan2(sqrt(a),sqrt(1-a))

    return (RADIUS * c)


def json(queryset):
    return HttpResponse(serializers.serialize('json',queryset),mimetype='application/json')

    
@csrf_exempt
def updatebiz(request):
    id=request.REQUEST.get('id',None)
    name=request.REQUEST.get('name',None)
    veteran_owned=request.REQUEST.get('veteran_owned',None)
    veteran_discounts=request.REQUEST.get('veteran_discounts',None)
    lat=request.REQUEST.get('lat',None)
    lon=request.REQUEST.get('lon',None)
    # TODO
    address=request.REQUEST.get('address',None)
    points_per_checkin=10
    category=None

    if id is not None and Business.objects.filter(id=id).exists():
        print 'update object with id: '+str(id)
        biz=Business.objects.filter(id=id)[0]
    else:
        if name is not None and Business.objects.filter(name=name).exists():
            print 'update object with name: '+str(name)
            biz=Business.objects.filter(name=name)[0]
        else:
            if name is not None:
                print 'create new object with name: '+str(name)
                biz=Business.objects.create(name=name)
            else:
                print 'no name, no update...'
                return json([])

    if veteran_owned is not None:
        biz.veteran_owned=(veteran_owned==True or veteran_owned=='true')
        print 'set veteran_owned: '+str(biz.veteran_owned)
    if veteran_discounts is not None:
        biz.veteran_discounts=(veteran_discounts==True or veteran_discounts=='true')
        print 'set veteran_discounts: '+str(biz.veteran_discounts)
    if address is not None:
        print 'set address: '+str(address)
        biz.address=address
    if lat is not None:
        biz.lat=float(lat)
    if lon is not None:
        biz.lon=float(lon)
    
    biz.save()

    return json([biz])

def getbiz(request):
    
    # return business details
    # lookup by id, name, location
    id=request.GET.get('id')
    name=request.GET.get('name')
    
    biz=[]
    if id is not None:
        biz=Business.objects.filter(id=id)
    else:
        if name is not None:
            biz=Business.objects.filter(name=name)
    
    return json(biz)


def in_radius(lat_x,lon_x,lat_y,lon_y,radius):
     
    dist=distance((lat_x,lon_x),(lat_y,lon_y))
    print "distance: "+str(dist)
    return dist <=radius

def searchbiz(request):
    # get businesses within radius of location
    lat=float(request.GET.get('lat'))
    lon=float(request.GET.get('lon'))
    radius=float(request.GET.get('radius'))
    # TODO:
    category=None
    query=None
    veteran_owned=False
    veteran_discounts=False
   
    results=[]
    offers=[]
    # TODO: filter on category, query, veteran criteria, etc.
    for biz in Business.objects.all():
        if in_radius(biz.lat,biz.lon,lat,lon,radius):
            offers.extend(biz.offer_set.all())
            results.append(biz)
    results.extend(offers)
    return json(results)

