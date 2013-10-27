/*!
 * jQuery Bootstrap Dropdown Select
 * Original author: @beezee	
 * Licensed under the MIT license
 */

// the semi-colon before the function invocation is a safety
// net against concatenated scripts and/or other plugins
// that are not closed properly.
;(function ( $, window, document, undefined ) {

    // undefined is used here as the undefined global
    // variable in ECMAScript 3 and is mutable (i.e. it can
    // be changed by someone else). undefined isn't really
    // being passed in so we can ensure that its value is
    // truly undefined. In ES5, undefined can no longer be
    // modified.

    // window and document are passed through as local
    // variables rather than as globals, because this (slightly)
    // quickens the resolution process and can be more
    // efficiently minified (especially when both are
    // regularly referenced in your plugin).

    // Create the defaults once
    var pluginName = "dropdownSelect",
        defaults = {
					link: $('<a></a>'),
					container: $('<div></div>')
        };

    // The actual plugin constructor
    function DropdownSelect( element, options ) {
        this.element = element;

        // jQuery has an extend method that merges the
        // contents of two or more objects, storing the
        // result in the first object. The first object
        // is generally empty because we don't want to alter
        // the default options for future instances of the plugin
        this.options = $.extend( {}, defaults, options) ;

        this._defaults = defaults;
        this._name = pluginName;

        this.init();
    }

    DropdownSelect.prototype = {

        init: function() {
						var self = this;
						self.container = self.options.container.clone();
						self.link = self.options.link.clone();
						self.createDropdown();
						self.bindChange();
        },

				createDropdown: function() {
					var self = this;
					$(self.element).hide();
					var ul = $('<ul class="dropdown-menu" role="menu" aria-labelledBy="dLabel"></ul>');	
					$(self.element).find('option').each(function(){
						ul.append($('<li><a class="bds-option" data-value="'+$(this).attr('value')+'">'
													+ $(this).text() + '</a></li>'));
					});
					self.link.attr('data-toggle', 'dropdown');
					self.container.addClass('dropdown');
					self.container.append(ul)
						.append(
							self.link.text($(self.element).find('option:selected').text())).insertAfter($(self.element));
				},

				updateValue: function(newValue) {
					var self = this;
					$(self.element).val(newValue).trigger('change');
					self.link.text($(self.element).find('option:selected').text());
				},

				bindChange: function() {
					var self = this;
					self.container.on('click.bds', '.bds-option', function(){
						self.updateValue($(this).data('value'));
					});	
				}
    };

    // A really lightweight plugin wrapper around the constructor,
    // preventing against multiple instantiations
    $.fn[pluginName] = function ( options ) {
        return this.each(function () {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName,
                new DropdownSelect( this, options ));
            }
        });
    };

})( jQuery, window, document );
