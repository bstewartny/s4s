from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.shortcuts import render_to_response,get_object_or_404
from django.template import RequestContext
import json
from vetbiz.models import *

def checkins(request):
    return render_to_response('vetbiz/checkins.html',{'context_type':'map','query':request.GET.get('q',''),'user':request.user,'checkins':Checkin.objects.filter(user=request.user)})

def offers(request):
    query=request.GET.get('q','')
    offers=None
    if len(query)>0:
        offers=Offer.objects.filter(title__icontains=query)
    else:
        offers=Offer.objects.all()
    return render_to_response('vetbiz/offers.html',{'context_type':'offers','query':request.GET.get('q',''),'user':request.user,'offers':offers})


def offer(request,offer_id):
    offer=get_object_or_404(Offer,pk=offer_id)
    return render_to_response('vetbiz/offer.html',{'context_type':'offers','query':request.GET.get('q',''),'user':request.user,'offer':offer})

def profile(request):
    return render_to_response('vetbiz/profile.html',{'context_type':'map','query':request.GET.get('q',''),'user':request.user,'checkins':Checkin.objects.filter(user=request.user),'businesses':Business.objects.filter(admin=request.user)})

def places(request):
    query=request.GET.get('q','')
    places=None
    if len(query)>0:
        places=Business.objects.filter(name__icontains=query)
    else:
        places=Business.objects.all()
    return render_to_response('vetbiz/places.html',{'context_type':'places','query':request.GET.get('q',''),'user':request.user,'places':places})

def place(request,place_id):
    place=get_object_or_404(Business,pk=place_id)
    return render_to_response('vetbiz/place.html',{'context_type':'places','query':request.GET.get('q',''),'user':request.user,'place':place},context_instance=RequestContext(request))

def saveplace(request,place_id):
    	place=get_object_or_404(Business,pk=place_id)
	if not place.admin==request.user:
		raise 'Current user is not administrator for this business!'
	if request.method=="POST":
		form=BusinessForm(request.POST,instance=place)
		if form.is_valid():
			form.save()
			return HttpResponseRedirect('/vetbiz/placeadmin/'+str(place.id))
		else:
			return HttpResponseRedirect('/vetbiz/placeedit/'+str(place.id))
	else:
		return HttpResponseRedirect('/vetbiz/placeedit/'+str(place.id))

def saveoffer(request,place_id):
    	place=get_object_or_404(Business,pk=place_id)
	if not place.admin==request.user:
		raise 'Current user is not administrator for this business!'
	if request.method=="POST":
		form=OfferForm(request.POST)
		if form.is_valid():
			print 'form is valid'
			form.save()
			return HttpResponseRedirect('/vetbiz/placeadmin/'+str(place.id))
		else:
			print 'form is NOT valid'
			return HttpResponseRedirect('/vetbiz/createoffer/'+str(place.id))
	else:
		return HttpResponseRedirect('/vetbiz/createoffer/'+str(place.id))
def placeedit(request,place_id):
    place=get_object_or_404(Business,pk=place_id)
    # verify user is admin for this business
    if not place.admin==request.user:
	raise 'Current user is not administrator for this business!'
    form=BusinessForm(instance=place)
    return render_to_response('vetbiz/placeedit.html',{'context_type':'places','query':request.GET.get('q',''),'user':request.user,'place':place,'form':form},context_instance=RequestContext(request))

def createjob(request,place_id):
    place=get_object_or_404(Business,pk=place_id)
    # verify user is admin for this business
    if not place.admin==request.user:
	raise 'Current user is not administrator for this business!'
    form=JobForm()
    return render_to_response('vetbiz/createjob.html',{'context_type':'places','query':request.GET.get('q',''),'user':request.user,'place':place,'form':form},context_instance=RequestContext(request))



def createoffer(request,place_id):
    place=get_object_or_404(Business,pk=place_id)
    # verify user is admin for this business
    if not place.admin==request.user:
	raise 'Current user is not administrator for this business!'
    form=OfferForm()
    return render_to_response('vetbiz/createoffer.html',{'context_type':'places','query':request.GET.get('q',''),'user':request.user,'place':place,'form':form},context_instance=RequestContext(request))


def placeadmin(request,place_id):
    place=get_object_or_404(Business,pk=place_id)
    # verify user is admin for this business
    if not place.admin==request.user:
	raise 'Current user is not administrator for this business!'
    offers=Offer.objects.filter(business=place)
    jobs=Job.objects.filter(business=place)
    return render_to_response('vetbiz/placeadmin.html',{'context_type':'places','query':request.GET.get('q',''),'user':request.user,'place':place,'offers':offers,'jobs':jobs},context_instance=RequestContext(request))

def jobs(request):
    query=request.GET.get('q','')
    jobs=None
    if len(query)>0:
        jobs=Job.objects.filter(title__icontains=query)
    else:
        jobs=Job.objects.all()
    return render_to_response('vetbiz/jobs.html',{'context_type':'jobs','query':request.GET.get('q',''),'user':request.user,'jobs':jobs})

def job(request,job_id):
    job=get_object_or_404(Job,pk=job_id)
    return render_to_response('vetbiz/job.html',{'context_type':'jobs','query':request.GET.get('q',''),'user':request.user,'job':job})

def search(request):
    return render_to_response('vetbiz/search.html',{'context_type':'map','query':request.GET.get('q',''),'user':request.user})

def signin(request):
    return render_to_response('vetbiz/signin.html',RequestContext(request))

def signup(request):
    return render_to_response('vetbiz/signup.html',RequestContext(request))
