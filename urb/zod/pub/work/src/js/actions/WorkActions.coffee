Dispatcher   = require '../dispatcher/Dispatcher.coffee'
Persistence  = require '../persistence/Persistence.coffee'

Persistence.get 'test', console.log.bind(console)
module.exports =
  newItem: (index,list) ->
    item =
      id:window.util.uuid32()
      version:0
      "date-created":Date.now()
      "date-modified":Date.now()
      "date-due":null
      done:null
      owner:window.urb.ship
      status:'announced'
      tags:[]
      title:''
      description:''
      discussion:[]
    station = window.util.talk.mainStationPath window.urb.ship
    Persistence.put "new": task:item, audience:[station]
    Dispatcher.handleViewAction {type:'newItem', index, item}

  setFilter: (key,val) ->
    Dispatcher.handleViewAction
      type:'setFilter'
      key:key
      val:val

  setSort: (key,val) ->
    Dispatcher.handleViewAction
      type:'setSort'
      key:key
      val:val

  swapItems: (to,from) ->
    Dispatcher.handleViewAction
      type:'swapItem'
      from:from
      to:to

  removeItem: (index,id) ->
    Persistence.put old:{id,dif:set:done:true}
    Dispatcher.handleViewAction
      type:'removeItem'
      index:index

  addItem: (index,item) ->
    Dispatcher.handleViewAction
      type:'addItem'
      index:index
      item:item
