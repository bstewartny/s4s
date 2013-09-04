from django.db import models
from django.forms import ValidationError
from django import forms
from django.contrib.auth.models import User



class UserProfile(models.Model):
    user=models.OneToOneField(User)
    veteran=models.BooleanField(default=False)
    points=models.IntegerField(default=0)
    checkins=models.IntegerField(default=0)

    def num_redemptions(self):
        return Redemption.objects.filter(user=self).count()

    def __unicode__(self):
        return self.user.username

class Category(models.Model):
    name=models.CharField(max_length=200)
    def __unicode__(self):
        return self.name

class Business(models.Model):
    name=models.CharField(max_length=200)
    category=models.ForeignKey(Category,null=True,blank=True)
    address=models.CharField(max_length=200,default='')
    lat=models.FloatField(default=0)
    lon=models.FloatField(default=0)
    veteran_owned=models.BooleanField(default=False)
    veteran_discounts=models.BooleanField(default=False)
    points_per_checkin=models.IntegerField(default=10)

    def num_checkins(self):
        return Checkin.objects.filter(business=self).count()
    
    def num_offers(self):
        return Offer.objects.filter(business=self).count()
    
    def num_redemptions(self):
        return Redemption.objects.filter(offer__business=self).count()
    
    def num_redemptions(self):
        return Redemption.objects.filter(offer__business=self).count()

    def __unicode__(self):
        return self.name

class Checkin(models.Model):
    user=models.ForeignKey(User)
    business=models.ForeignKey(Business)
    date=models.DateTimeField(auto_now=True)

    # when user checks in they get some points based on business setting for points per checkin...
    def save(self,*args,**kwargs):
        super(Checkin,self).save(*args,**kwargs)
        # TODO: if user did not check in already today...
        #if not Checkin.objects.exists(user=self.user,business=self.business,date__date=self.date.date):
        # TODO: get user profile
        #self.user.points=self.user.points+self.business.points_per_checkin
        #self.user.checkins=self.user.checkins+1
        
        #self.user.save()
        

    def __unicode__(self):
        return self.business.name

class Offer(models.Model):
    business=models.ForeignKey(Business)
    title=models.CharField(max_length=200)
    description=models.CharField(max_length=200,null=True,blank=True)
    points=models.IntegerField(default=0)
    veterans_only=models.BooleanField(default=False)
    start_date=models.DateTimeField(auto_now_add=True)
    end_date=models.DateTimeField(null=True,blank=True)
    def num_redemptions(self):
        return Redemption.objects.filter(offer=self).count()
    def __unicode__(self):
        return self.title

class Job(models.Model):
    business=models.ForeignKey(Business)
    title=models.CharField(max_length=200)
    description=models.TextField(null=True,blank=True)
    category=models.CharField(max_length=200,null=True,blank=True)
    start_date=models.DateTimeField(auto_now_add=True)
    end_date=models.DateTimeField(null=True,blank=True)
    contact_phone=models.CharField(max_length=200,null=True,blank=True)
    contact_email=models.CharField(max_length=200,null=True,blank=True)
    contact_link=models.CharField(max_length=200,null=True,blank=True)
    education_level=models.CharField(max_length=200,null=True,blank=True)
    experience_years=models.CharField(max_length=200,null=True,blank=True)
    reference_code=models.CharField(max_length=200,null=True,blank=True)

    def address(self):
        return self.business.address

    def __unicode__(self):
        return self.title

class Redemption(models.Model):
    offer=models.ForeignKey(Offer)
    user=models.ForeignKey(User)
    date=models.DateTimeField(auto_now=True)

    def user_name(self):
        return self.user.username
    
    def business(self):
        return self.offer.business.name
    
    def category(self):
        return self.offer.business.category.name

    def offer_title(self):
        return self.offer.title

    def offer_points(self):
        return self.offer.points

    def save(self,*args,**kwargs):
        # TODO: get user profile...
        #if self.user.points<self.offer.points:
        #    raise ValidationError("User does not have enough points for this offer.")
        #if self.offer.veterans_only and not self.user.veteran:
        #    raise ValidationError("User must be a veteran for this offer.")
        # TODO: make sure offer already started and is not expired...

        super(Redemption,self).save(*args,**kwargs)
        # TODO: if user did not check in already today...
        #if not Checkin.objects.exists(user=self.user,business=self.business,date__date=self.date.date):
        #self.user.points=self.user.points-self.offer.points
        
        #self.user.save()
    
