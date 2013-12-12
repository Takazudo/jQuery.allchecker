/*! jQuery.allchecker (https://github.com/Takazudo/jQuery.allchecker)
 * lastupdate: 2013-12-13
 * version: 0.1.0
 * author: 'Takazudo' Takeshi Takatsudo <takazudo@gmail.com>
 * License: MIT */
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  (function($, window) {
    var EveEve, ns;
    EveEve = window.EveEve;
    ns = {};
    ns.Main = (function(_super) {

      __extends(Main, _super);

      Main.defaults = {
        selector_parent_check: null,
        selector_children_check: null,
        initialCheck_fromParent: true,
        initialCheck_fromChildren: false
      };

      function Main($el, options) {
        this.$el = $el;
        if (options == null) {
          options = {};
        }
        this.options = $.extend({}, ns.Main.defaults, options);
        this._prepareEls();
        this._eventify();
        if (this.options.initialCheck_fromParent) {
          this.handleChildrenStatsFromParent();
        }
        if (this.options.initialCheck_fromChildren) {
          this.handleParentStatsFromChildren();
        }
      }

      Main.prototype.handleChildrenStatsFromParent = function() {
        if (this.$checker_parent.is(':checked')) {
          this.checkAllChildren();
        } else {
          this.uncheckAllChildren();
        }
        return this;
      };

      Main.prototype.handleParentStatsFromChildren = function() {
        if (this.allChecked()) {
          this.$checker_parent.prop('checked', true);
        } else {
          this.$checker_parent.prop('checked', false);
        }
        return this;
      };

      Main.prototype.checkAllChildren = function() {
        var check, _i, _len, _ref;
        _ref = this.$checkers_children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          check = _ref[_i];
          $(check).prop('checked', true);
        }
        return this;
      };

      Main.prototype.uncheckAllChildren = function() {
        var check, _i, _len, _ref;
        _ref = this.$checkers_children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          check = _ref[_i];
          $(check).prop('checked', false);
        }
        return this;
      };

      Main.prototype.allChecked = function() {
        var checker, ret, _i, _len, _ref;
        ret = true;
        _ref = this.$checkers_children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          checker = _ref[_i];
          if (!$(checker).is(':checked')) {
            ret = false;
            break;
          }
        }
        return ret;
      };

      Main.prototype.allUnchecked = function() {
        var checker, ret, _i, _len, _ref;
        ret = true;
        _ref = this.$checkers_children;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          checker = _ref[_i];
          if ($(checker).is(':checked')) {
            ret = false;
            break;
          }
        }
        return ret;
      };

      Main.prototype._eventify = function() {
        var o,
          _this = this;
        o = this.options;
        this.$el.delegate(o.selector_parent_check, 'click', function(e) {
          _this.handleChildrenStatsFromParent();
          _this._triggerEvent('parentcheck', e.currentTarget);
          return _this._triggerEvent('change');
        });
        this.$el.delegate(o.selector_children_check, 'click', function(e) {
          _this.handleParentStatsFromChildren();
          _this._triggerEvent('childcheck', e.currentTarget);
          return _this._triggerEvent('change');
        });
        return this;
      };

      Main.prototype._triggerEvent = function() {
        var args;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        this.trigger.apply(this, args);
        return this;
      };

      Main.prototype._prepareEls = function() {
        var o;
        o = this.options;
        this.$checker_parent = this.$el.find(o.selector_parent_check);
        this.$checkers_children = this.$el.find(o.selector_children_check);
        return this;
      };

      return Main;

    })(EveEve);
    $.fn.allchecker = function(options) {
      return this.each(function() {
        var $el, tab;
        $el = $(this);
        tab = new ns.Main($el, options);
        $el.data('allchecker', tab);
      });
    };
    $.AllCheckerNs = ns;
    return $.AllChecker = ns.Main;
  })(jQuery, window);

}).call(this);
