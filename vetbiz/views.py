from django.http import HttpResponse
from django.shortcuts import render
from django.shortcuts import render_to_response
from django.template import RequestContext
import json
from vetbiz.models import *

def offers(request):
    return render_to_response('vetbiz/offers.html',{'query':request.GET.get('q',''),'user':request.user,'offers':Offer.objects.all()})

def jobs(request):
    return render_to_response('vetbiz/jobs.html',{'query':request.GET.get('q',''),'user':request.user,'jobs':[]})

def search(request):
    return render_to_response('vetbiz/search.html',{'query':request.GET.get('q',''),'user':request.user})

def signin(request):
    return render_to_response('vetbiz/signin.html',RequestContext(request))

def signup(request):
    return render_to_response('vetbiz/signup.html',RequestContext(request))
