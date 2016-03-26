kd                     = require 'kd'
AccountSessionListItem = require 'account/accountsessionlistitem'
KodingListController   = require 'app/kodinglist/kodinglistcontroller'
kookies                = require 'kookies'
whoami                 = require 'app/util/whoami'

module.exports = class HomeAccountSessionsView extends kd.CustomHTMLView

  constructor: (options = {}, data) ->

    super options, data

    @addSubView @top = new kd.CustomHTMLView
      cssClass : 'top'

    @top.addSubView @header = new kd.HeaderView
      title : 'Active Sessions'

    @listController = new KodingListController
      limit               : 8
      lazyLoadThreshold   : 8
      wrapper             : no
      scrollView          : no
      useCustomScrollView : no
      noItemFoundText     : 'You have no active session.'
      itemClass           : AccountSessionListItem
      fetcherMethod       : (query, options, callback) ->
        whoami().fetchMySessions options, (err, sessions)  -> callback err, sessions

    @listController.getListView().on 'ItemWasRemoved', (item) ->
      session  = item.getData()
      clientId = kookies.get 'clientId'

      # if the deleted session is the current one logout user immediately
      if clientId is session.clientId
        kookies.expire 'clientId'
        global.location.replace '/'

    @addSubView @listController.getView()
