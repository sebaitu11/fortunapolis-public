Marionette.Region.prototype.open = function(view){
  this.$el.hide();
  this.$el.html(view.el);
  this.$el.fadeIn(150);
}