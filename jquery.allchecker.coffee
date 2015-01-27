do ($ = jQuery, window = window) ->

  EveEve = window.EveEve

  ns = {}

  # ============================================================
  # utils
  
  # ============================================================
  # Tab

  class ns.Main extends EveEve
    
    @defaults =
      selector_parent_check: null # required
      selector_children_check: null # required
      initialCheck_fromParent: true
      initialCheck_fromChildren: false
      use_eventDelegation: true

    constructor: (@$el, options = {}) ->

      @options = $.extend {}, ns.Main.defaults, options
      @refreshElements true
      @_eventify()
      @handleChildrenStatsFromParent() if @options.initialCheck_fromParent
      @handleParentStatsFromChildren() if @options.initialCheck_fromChildren

    handleChildrenStatsFromParent: ->

      if @$checker_parent.is ':checked'
        @checkAllChildren()
      else
        @uncheckAllChildren()
      return this
      
    handleParentStatsFromChildren: ->

      if @allChecked()
        @$checker_parent.prop 'checked', true
      else
        @$checker_parent.prop 'checked', false
      return this

    checkAllChildren: ->
      
      for check in @$checkers_children
        $(check).prop 'checked', true
      return this

    uncheckAllChildren: ->

      for check in @$checkers_children
        $(check).prop 'checked', false
      return this

    allChecked: ->

      ret = true
      for checker in @$checkers_children
        unless $(checker).is ':checked'
          ret = false
          break
      return ret

    allUnchecked: ->

      ret = true
      for checker in @$checkers_children
        if $(checker).is ':checked'
          ret = false
          break
      return ret

    # private

    _eventify: ->

      o = @options
      
      parentClickHandler = (e) =>
        @handleChildrenStatsFromParent()
        @_triggerEvent 'parentcheck', e.currentTarget
        @_triggerEvent 'change'
      
      childrenClickHandler = (e) =>
        @handleParentStatsFromChildren()
        @_triggerEvent 'childcheck', e.currentTarget
        @_triggerEvent 'change'
      
      if o.use_eventDelegation
        @$el.delegate o.selector_parent_check, 'click', parentClickHandler
        @$el.delegate o.selector_children_check, 'click', childrenClickHandler
      else
        $(o.selector_parent_check, @$el).bind 'click', parentClickHandler
        $(o.selector_children_check, @$el).bind 'click', childrenClickHandler

      return this

    _triggerEvent: (args...) ->

      @trigger.apply this, args
      return this

    refreshElements: (skipCheck = false) ->

      o = @options
      @$checker_parent = @$el.find o.selector_parent_check
      @$checkers_children = @$el.find o.selector_children_check
      @handleParentStatsFromChildren() unless skipCheck
      return this


  # ============================================================
  # jQuery bridges

  $.fn.allchecker = (options) ->

    return @each ->

      $el = $(@)
      allchecker = new ns.Main $el, options
      $el.data 'allchecker', allchecker
      return

  # ============================================================
  # globalify

  $.AllCheckerNs = ns
  $.AllChecker = ns.Main


