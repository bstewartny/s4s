import BeautifulSoup as bs
import urllib2

states=['ny']

counties=['suffolk']

BASE='http://www.veteranownedbusinesses.com'

def get_website(url):
    return urllib2.urlopen(url)

def get_counties_for_state(state):
    return ['suffolk']

def crawl_county(state,county):
    website=BASE+'/'+state+'/'+county
    s=get_soup(website)
    companies=[]
    for n in s.findAll('tr',{'class':'top_level_listing'}):
        #try:
            info=n.find('span',{'class':'info'}).contents
            a=n.find('a')
            name=a.contents[0]
            link=a.get('href')
            if link is None:
                continue
            detail_page=get_soup(BASE+link)
            details=detail_page.find('div',{'id':'business_info'})
            address=details.find('p',{'class':'address'}).contents
            address=address[1].contents+' '+address[3].contents +' '+address[5].contents+' '+address[6].contents
            contact=details.find('p',{'class':'contact_info'}).getText()
            print 'address: '+address
            print 'contact: '+contact
            obj={'state':state,'county':county,'name':name,'link':link,'info':info,'address':address,'contact':contact}
            companies.append(obj)
        #except:
        #    print 'failed!'
    return companies

def get_soup(url):
    return bs.BeautifulSoup(get_website(url))



def crawl_state(state):
    companies=[]
    for county in get_counties_for_state(state):
        companies.extend(crawl_county(state,county))
    return companies


def crawl():
    companies=[]
    for state in states:
        companies.extend(crawl_state(state))
    return companies
