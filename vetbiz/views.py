from django.http import HttpResponse
from django.shortcuts import render
from django.shortcuts import render_to_response
import json
from vetbiz.models import *

def search(request):
    return render_to_response('vetbiz/search.html',locals())
