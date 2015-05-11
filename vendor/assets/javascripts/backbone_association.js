(function(x,f){if("function"===typeof define&&define.amd)define(["underscore","backbone"],function(h,r){return f(x,r,h)});else if("undefined"!==typeof exports){var h=require("underscore"),r=require("backbone");f(x,r,h);"undefined"!==typeof module&&module.exports&&(module.exports=r);exports=r}else f(x,x.Backbone,x._)})(this,function(x,f,h){var r,u,y,z,l,v,F,G,p,C,H,t={};r=f.Model;u=f.Collection;y=r.prototype;l=u.prototype;z=f.Events;f.Associations={VERSION:"0.6.1"};f.Associations.scopes=[];var I=function(){return p},
D=function(a){if(!h.isString(a)||1>h.size(a))a=".";p=a;F=RegExp("[\\"+p+"\\[\\]]+","g");G=RegExp("[^\\"+p+"\\[\\]]+","g")};try{Object.defineProperty(f.Associations,"SEPARATOR",{enumerable:!0,get:I,set:D})}catch(L){}f.Associations.Many=f.Many="Many";f.Associations.One=f.One="One";f.Associations.Self=f.Self="Self";f.Associations.SEPARATOR=".";f.Associations.getSeparator=I;f.Associations.setSeparator=D;f.Associations.EVENTS_BUBBLE=!0;f.Associations.EVENTS_WILDCARD=!0;f.Associations.EVENTS_NC=!1;D();
v=f.AssociatedModel=f.Associations.AssociatedModel=r.extend({relations:void 0,_proxyCalls:void 0,on:function(a,d,c){var b=z.on.apply(this,arguments);if(f.Associations.EVENTS_NC)return b;var s=/\s+/;h.isString(a)&&a&&!s.test(a)&&d&&(s=E(a))&&(t[s]="undefined"===typeof t[s]?1:t[s]+1);return b},off:function(a,d,c){if(f.Associations.EVENTS_NC)return z.off.apply(this,arguments);var b=/\s+/,s=this._events,e={},g=s?h.keys(s):[],m=!a&&!d&&!c,w=h.isString(a)&&!b.test(a);if(m||w)for(var b=0,k=g.length;b<k;b++)e[g[b]]=
s[g[b]]?s[g[b]].length:0;var q=z.off.apply(this,arguments);if(m||w)for(b=0,k=g.length;b<k;b++)(m=E(g[b]))&&(t[m]=s[g[b]]?t[m]-(e[g[b]]-s[g[b]].length):t[m]-e[g[b]]);return q},get:function(a){var d=y.get.call(this,a);return d?d:this._getAttr.apply(this,arguments)},set:function(a,d,c){var b;h.isObject(a)||null==a?(b=a,c=d):(b={},b[a]=d);a=this._set(b,c);this._processPendingEvents();return a},_set:function(a,d){var c,b,f,e,g=this;if(!a)return this;for(c in a)if(b||(b={}),c.match(F)){var m=J(c);e=h.initial(m);
m=m[m.length-1];e=this.get(e);e instanceof v&&(e=b[e.cid]||(b[e.cid]={model:e,data:{}}),e.data[m]=a[c])}else e=b[this.cid]||(b[this.cid]={model:this,data:{}}),e.data[c]=a[c];if(b)for(f in b)e=b[f],this._setAttr.call(e.model,e.data,d)||(g=!1);else g=this._setAttr.call(this,a,d);return g},_setAttr:function(a,d){var c;d||(d={});if(d.unset)for(c in a)a[c]=void 0;this.parents=this.parents||[];this.relations&&h.each(this.relations,function(b){var c=b.key,e=b.relatedModel,g=b.collectionType,m=b.scope||x,
w=b.map,k=this.attributes[c],q=k&&k.idAttribute,n,p,l,t=!1;!e||e.prototype instanceof r||(e=h.isFunction(e)?e.call(this,b,a):e);e&&h.isString(e)&&(e=e===f.Self?this.constructor:A(e,m));w&&h.isString(w)&&(w=A(w,m));p=b.options?h.extend({},b.options,d):d;if(a[c]){n=h.result(a,c);n=w?w.call(this,n,g?g:e):n;if(b.type===f.Many){if(g&&h.isFunction(g)&&g.prototype instanceof r)throw Error("type is of Backbone.Model. Specify derivatives of Backbone.Collection");!g||g.prototype instanceof u||(g=h.isFunction(g)?
g.call(this,b,a):g);g&&h.isString(g)&&(g=A(g,m));if(!e&&!g)throw Error("specify either a relatedModel or collectionType");if(g&&!g.prototype instanceof u)throw Error("collectionType must inherit from Backbone.Collection");k?(k._deferEvents=!0,k[p.reset?"reset":"set"](n instanceof u?n.models:n,p),b=k):(t=!0,n instanceof u?b=n:(b=g?new g:this._createCollection(e,m),b[p.reset?"reset":"set"](n,p)))}else if(b.type===f.One){if(!e)throw Error("specify a relatedModel for Backbone.One type");if(!(e.prototype instanceof
f.AssociatedModel))throw Error("specify an AssociatedModel for Backbone.One type");b=n instanceof v?n:new e(n,p);k&&b.attributes[q]&&k.attributes[q]===b.attributes[q]?(k._deferEvents=!0,k._set(n instanceof v?n.attributes:n,p),b=k):t=!0}else throw Error("type attribute must be specified and have the values Backbone.One or Backbone.Many");l=a[c]=b;if(t||l&&!l._proxyCallback)l._proxyCallback=function(){return f.Associations.EVENTS_BUBBLE&&this._bubbleEvent.call(this,c,l,arguments)},l.on("all",l._proxyCallback,
this)}a.hasOwnProperty(c)&&(k=a[c],q=this.attributes[c],k?(k.parents=k.parents||[],-1==h.indexOf(k.parents,this)&&k.parents.push(this)):q&&0<q.parents.length&&(q.parents=h.difference(q.parents,[this]),q._proxyCallback&&q.off("all",q._proxyCallback,this)))},this);return y.set.call(this,a,d)},_bubbleEvent:function(a,d,c){var b=c[0].split(":"),h=b[0],e="nested-change"==c[0],g="change"===h,m=c[1],l=-1,k=d._proxyCalls,b=b[1],q=!b||-1==b.indexOf(p),n;if(!e&&(q&&(H=E(c[0])||a),f.Associations.EVENTS_NC||
t[H])){if(f.Associations.EVENTS_WILDCARD&&/\[\*\]/g.test(b))return this;d instanceof u&&(g||b)&&(l=d.indexOf(C||m));this instanceof r&&(C=this);b=a+(-1!==l&&(g||b)?"["+l+"]":"")+(b?p+b:"");f.Associations.EVENTS_WILDCARD&&(n=b.replace(/\[\d+\]/g,"[*]"));e=[];e.push.apply(e,c);e[0]=h+":"+b;f.Associations.EVENTS_WILDCARD&&b!==n&&(e[0]=e[0]+" "+h+":"+n);k=d._proxyCalls=k||{};if(this._isEventAvailable.call(this,k,b))return this;k[b]=!0;g&&(this._previousAttributes[a]=d._previousAttributes,this.changed[a]=
d);this.trigger.apply(this,e);f.Associations.EVENTS_NC&&(g&&this.get(b)!=c[2])&&(a=["nested-change",b,c[1]],c[2]&&a.push(c[2]),this.trigger.apply(this,a));k&&b&&delete k[b];C=void 0;return this}},_isEventAvailable:function(a,d){return h.find(a,function(a,b){return-1!==d.indexOf(b,d.length-b.length)})},_createCollection:function(a,d){var c,b=a;h.isString(b)&&(b=A(b,d));if(b&&b.prototype instanceof v||h.isFunction(b))c=new u,c.model=b;else throw Error("type must inherit from Backbone.AssociatedModel");
return c},_processPendingEvents:function(){this._processedEvents||(this._processedEvents=!0,this._deferEvents=!1,h.each(this._pendingEvents,function(a){a.c.trigger.apply(a.c,a.a)}),this._pendingEvents=[],h.each(this.relations,function(a){(a=this.attributes[a.key])&&a._processPendingEvents()},this),delete this._processedEvents)},trigger:function(a){this._deferEvents?(this._pendingEvents=this._pendingEvents||[],this._pendingEvents.push({c:this,a:arguments})):y.trigger.apply(this,arguments)},toJSON:function(a){var d=
{},c;d[this.idAttribute]=this.id;this.visited||(this.visited=!0,d=y.toJSON.apply(this,arguments),a&&a.serialize_keys&&(d=h.pick(d,a.serialize_keys)),this.relations&&h.each(this.relations,function(b){var f=b.key,e=b.remoteKey,g=this.attributes[f],m=!b.isTransient;b=b.serialize||[];delete d[f];m&&(b.length&&(a?a.serialize_keys=b:a={serialize_keys:b}),c=g&&g.toJSON?g.toJSON(a):g,d[e||f]=h.isArray(c)?h.compact(c):c)},this),delete this.visited);return d},clone:function(a){return new this.constructor(this.toJSON(a))},
cleanup:function(){h.each(this.relations,function(a){(a=this.attributes[a.key])&&(a.parents=h.difference(a.parents,[this]))},this);this.off()},_getAttr:function(a){var d=this;a=J(a);var c,b;if(!(1>h.size(a))){for(b=0;b<a.length;b++){c=a[b];if(!d)break;d=d instanceof u?isNaN(c)?void 0:d.at(c):d.attributes[c]}return d}}});var J=function(a){return""===a?[""]:h.isString(a)?a.match(G):a||[]},E=function(a){if(!a)return a;a=a.split(":");return 1<a.length?(a=a[a.length-1],a=a.split(p),1<a.length?a[a.length-
1].split("[")[0]:a[0].split("[")[0]):""},A=function(a,d){var c,b=[d];b.push.apply(b,f.Associations.scopes);for(var l,e=0,g=b.length;e<g;++e)if(l=b[e])if(c=h.reduce(a.split(p),function(a,b){return a[b]},l))break;return c},K=function(a,d,c){var b,f;h.find(a,function(a){if(b=h.find(a.relations,function(b){return a.get(b.key)===d},this))return f=a,!0},this);return b&&b.map?b.map.call(f,c,d):c},B={};h.each(["set","remove","reset"],function(a){B[a]=u.prototype[a];l[a]=function(d,c){this.model.prototype instanceof
v&&this.parents&&(arguments[0]=K(this.parents,this,d));return B[a].apply(this,arguments)}});B.trigger=l.trigger;l.trigger=function(a){this._deferEvents?(this._pendingEvents=this._pendingEvents||[],this._pendingEvents.push({c:this,a:arguments})):B.trigger.apply(this,arguments)};l._processPendingEvents=v.prototype._processPendingEvents;l.on=v.prototype.on;l.off=v.prototype.off;return f});