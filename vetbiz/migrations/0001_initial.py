# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'UserProfile'
        db.create_table(u'vetbiz_userprofile', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('user', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['auth.User'], unique=True)),
            ('veteran', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('points', self.gf('django.db.models.fields.IntegerField')(default=0)),
            ('checkins', self.gf('django.db.models.fields.IntegerField')(default=0)),
        ))
        db.send_create_signal(u'vetbiz', ['UserProfile'])

        # Adding model 'Category'
        db.create_table(u'vetbiz_category', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=200)),
        ))
        db.send_create_signal(u'vetbiz', ['Category'])

        # Adding model 'Business'
        db.create_table(u'vetbiz_business', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('category', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['vetbiz.Category'], null=True, blank=True)),
            ('address', self.gf('django.db.models.fields.CharField')(default='', max_length=200)),
            ('lat', self.gf('django.db.models.fields.FloatField')(default=0)),
            ('lon', self.gf('django.db.models.fields.FloatField')(default=0)),
            ('veteran_owned', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('veteran_discounts', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('points_per_checkin', self.gf('django.db.models.fields.IntegerField')(default=10)),
        ))
        db.send_create_signal(u'vetbiz', ['Business'])

        # Adding model 'Checkin'
        db.create_table(u'vetbiz_checkin', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('business', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['vetbiz.Business'])),
            ('date', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
        ))
        db.send_create_signal(u'vetbiz', ['Checkin'])

        # Adding model 'Offer'
        db.create_table(u'vetbiz_offer', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('business', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['vetbiz.Business'])),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('description', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
            ('points', self.gf('django.db.models.fields.IntegerField')(default=0)),
            ('veterans_only', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('start_date', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('end_date', self.gf('django.db.models.fields.DateTimeField')(null=True, blank=True)),
        ))
        db.send_create_signal(u'vetbiz', ['Offer'])

        # Adding model 'Job'
        db.create_table(u'vetbiz_job', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('business', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['vetbiz.Business'])),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('description', self.gf('django.db.models.fields.TextField')(null=True, blank=True)),
            ('category', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
            ('start_date', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
            ('end_date', self.gf('django.db.models.fields.DateTimeField')(null=True, blank=True)),
            ('contact_phone', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
            ('contact_email', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
            ('contact_link', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
            ('education_level', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
            ('experience_years', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
            ('reference_code', self.gf('django.db.models.fields.CharField')(max_length=200, null=True, blank=True)),
        ))
        db.send_create_signal(u'vetbiz', ['Job'])

        # Adding model 'Redemption'
        db.create_table(u'vetbiz_redemption', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('offer', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['vetbiz.Offer'])),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('date', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
        ))
        db.send_create_signal(u'vetbiz', ['Redemption'])


    def backwards(self, orm):
        # Deleting model 'UserProfile'
        db.delete_table(u'vetbiz_userprofile')

        # Deleting model 'Category'
        db.delete_table(u'vetbiz_category')

        # Deleting model 'Business'
        db.delete_table(u'vetbiz_business')

        # Deleting model 'Checkin'
        db.delete_table(u'vetbiz_checkin')

        # Deleting model 'Offer'
        db.delete_table(u'vetbiz_offer')

        # Deleting model 'Job'
        db.delete_table(u'vetbiz_job')

        # Deleting model 'Redemption'
        db.delete_table(u'vetbiz_redemption')


    models = {
        u'auth.group': {
            'Meta': {'object_name': 'Group'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        u'auth.permission': {
            'Meta': {'ordering': "(u'content_type__app_label', u'content_type__model', u'codename')", 'unique_together': "((u'content_type', u'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['contenttypes.ContentType']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        u'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['auth.Group']", 'symmetrical': 'False', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        u'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        u'vetbiz.business': {
            'Meta': {'object_name': 'Business'},
            'address': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '200'}),
            'category': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['vetbiz.Category']", 'null': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'lat': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            'lon': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'points_per_checkin': ('django.db.models.fields.IntegerField', [], {'default': '10'}),
            'veteran_discounts': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'veteran_owned': ('django.db.models.fields.BooleanField', [], {'default': 'False'})
        },
        u'vetbiz.category': {
            'Meta': {'object_name': 'Category'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        },
        u'vetbiz.checkin': {
            'Meta': {'object_name': 'Checkin'},
            'business': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['vetbiz.Business']"}),
            'date': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['auth.User']"})
        },
        u'vetbiz.job': {
            'Meta': {'object_name': 'Job'},
            'business': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['vetbiz.Business']"}),
            'category': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            'contact_email': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            'contact_link': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            'contact_phone': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            'description': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'education_level': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            'end_date': ('django.db.models.fields.DateTimeField', [], {'null': 'True', 'blank': 'True'}),
            'experience_years': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'reference_code': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            'start_date': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        },
        u'vetbiz.offer': {
            'Meta': {'object_name': 'Offer'},
            'business': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['vetbiz.Business']"}),
            'description': ('django.db.models.fields.CharField', [], {'max_length': '200', 'null': 'True', 'blank': 'True'}),
            'end_date': ('django.db.models.fields.DateTimeField', [], {'null': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'points': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
            'start_date': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'veterans_only': ('django.db.models.fields.BooleanField', [], {'default': 'False'})
        },
        u'vetbiz.redemption': {
            'Meta': {'object_name': 'Redemption'},
            'date': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'offer': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['vetbiz.Offer']"}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['auth.User']"})
        },
        u'vetbiz.userprofile': {
            'Meta': {'object_name': 'UserProfile'},
            'checkins': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'points': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
            'user': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['auth.User']", 'unique': 'True'}),
            'veteran': ('django.db.models.fields.BooleanField', [], {'default': 'False'})
        }
    }

    complete_apps = ['vetbiz']