from django.http import HttpResponse
from django.shortcuts import render
from django.shortcuts import redirect
from django.shortcuts import render_to_response,get_object_or_404
from django.core import serializers
import json
from vetbiz.models import *
from math import *
from django.views.decorators.csrf import requires_csrf_token
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.decorators import login_required
from django.template import RequestContext

RADIUS=6371 # Earth's mean radius in km

def distance(a,b):
    (lat1,lon1)=(a[0],a[1])
    (lat2,lon2)=(b[0],b[1])
    dLat=radians(lat1-lat2)
    dLon=radians(lon1-lon2)
    a=sin(dLat/2)*sin(dLat/2)+cos(radians(lat1))*cos(radians(lat2))*sin(dLon/2)*sin(dLon/2)
    c=2*atan2(sqrt(a),sqrt(1-a))
    # multiply by 1000 to get distance in meters instead of KM
    return 1000.0 * (RADIUS * c)


def json(queryset):
    return HttpResponse(serializers.serialize('json',queryset),mimetype='application/json')

def profile(request):
    # return user profile info (username, id, # of points, last checkins, etc.)
    pass

def dologout(request):
    logout(request)
    return HttpResponse('ok')

def unique(request):
    username=request.GET.get('username',None)
    if username is not None:
        # TODO: make sure we do case-insensitive compare, and trim any extra whitespace...
        if User.objects.filter(username=username).exists():
            # user already exists...
            return HttpResponse('false');
        else:
            return HttpResponse('true');
    else:
        return HttpResponse('false');

def signin(request):
    username=request.POST.get('username',None)
    password=request.POST.get('password',None)
    user=authenticate(username=username,password=password)
    if user is not None:
        if user.is_active:
            # user is a ok
            login(request,user)
            return redirect('/vetbiz/')
        else:
            return redirect('/vetbiz/signin/')
            # user is not ok
    else:
        # failed
        return redirect('/vetbiz/signin/')

def signup(request):
    username=request.POST.get('username',None)
    password=request.POST.get('password',None)
    password2=request.POST.get('password2',None)
    email=request.POST.get('email',None)
    if not username:
        return redirect('/vetbiz/signup/')
    if not password:
        return redirect('/vetbiz/signup/')
    if not password==password2:
        return redirect('/vetbiz/signup/')
    if not email:
        return redirect('/vetbiz/signup/')

    # TODO: get if user is veteran and what service branch...
    # TODO: if vet, when they served and what capacity (what rank, what job/skills)
    # TODO: if military: then what is status (vet, or active)

    # create user account
    if User.objects.filter(username=username).exists():
        # such a user already exists
        return redirect('/vetbiz/signup/')
    else:
        user=User.objects.create_user(username,email,password)
        user.save()
        # TODO:create user profile with additional info from reg screen...

    
        user=authenticate(username=username,password=password)
        login(request,user)
        return redirect('/vetbiz/')

@login_required
def checkin(request):
    # checkin to business
    business=get_object_or_404(Business,pk=request.REQUEST.get('id',None))

    checkin=Checkin.objects.create(business=business,user=request.user)
    checkin.save()
        
    return HttpResponse('ok')

@login_required
def checkins(request):
    # get user checkin history
    pass

@login_required
def redeemoffer(request):
    # redeem offer 
    # create redemption for biz
    # deduct user points and record it
    pass

def bizinfo(request):
    # get all info for a business including any offers
    pass




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
        biz=Business.objects.filter(id=id)[0]
    else:
        if name is not None and Business.objects.filter(name=name).exists():
            biz=Business.objects.filter(name=name)[0]
        else:
            if name is not None:
                biz=Business.objects.create(name=name)
            else:
                return json([])

    if veteran_owned is not None:
        biz.veteran_owned=(veteran_owned==True or veteran_owned=='true')
    if veteran_discounts is not None:
        biz.veteran_discounts=(veteran_discounts==True or veteran_discounts=='true')
    if address is not None:
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
    print 'found '+str(len(results)) +' nearby businesses'
    results.extend(offers)
    return json(results)

