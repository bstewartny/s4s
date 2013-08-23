from django.http import HttpResponse
from django.shortcuts import render
from django.shortcuts import render_to_response
from django.template import RequestContext
import json
from vetbiz.models import *

def checkins(request):
    return render_to_response('vetbiz/checkins.html',{'query':request.GET.get('q',''),'user':request.user,'checkins':Checkin.objects.all()})

def offers(request):
    return render_to_response('vetbiz/offers.html',{'query':request.GET.get('q',''),'user':request.user,'offers':Offer.objects.all()})

def offer(request):
    return render_to_response('vetbiz/offer.html',{'query':request.GET.get('q',''),'user':request.user,'offer':{}})

def profile(request):
    return render_to_response('vetbiz/profile.html',{'query':request.GET.get('q',''),'user':request.user,'profile':{}})

def places(request):
    return render_to_response('vetbiz/places.html',{'query':request.GET.get('q',''),'user':request.user,'places':Business.objects.all()})

def place(request):
    return render_to_response('vetbiz/place.html',{'query':request.GET.get('q',''),'user':request.user,'place':{}})

def jobs(request):
    return render_to_response('vetbiz/jobs.html',{'query':request.GET.get('q',''),'user':request.user,'jobs':Job.objects.all()})

def job(request):
    return render_to_response('vetbiz/job.html',{'query':request.GET.get('q',''),'user':request.user,'job':{}})

def search(request):
    return render_to_response('vetbiz/search.html',{'query':request.GET.get('q',''),'user':request.user})

def signin(request):
    return render_to_response('vetbiz/signin.html',RequestContext(request))

def signup(request):
    return render_to_response('vetbiz/signup.html',RequestContext(request))
