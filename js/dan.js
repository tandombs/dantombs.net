(function(){var e,t=this;window.Site=function(){function e(t){var n=this;t==null&&(t="");this.fetch=function(){return e.prototype.fetch.apply(n,arguments)};this.url=t;this.response=this.fetch()}e.prototype.fetch=function(){return $.getJSON("http://pipes.yahoo.com/pipes/pipe.run?_callback=?",{url:this.url,_id:"4b4d3ea82bfcdbe9b6daca620fc989d3",_render:"json"}).pipe(function(e){return e.value.items[0]})};return e}();e=function(){function e(t){var n=this;t==null&&(t=[]);this.get=function(){return e.prototype.get.apply(n,arguments)};this.urls=t;this._sites=[]}e.prototype.get=function(e){var t;return(t=this._sites)[e]||(t[e]=new Site(this.urls[e]))};return e}();window.Dan=function(){function t(n,r){var i=this;n==null&&(n=[]);r==null&&(r=[]);this.init=function(){return t.prototype.init.apply(i,arguments)};this.doIt=function(){return t.prototype.doIt.apply(i,arguments)};this.renderSite=function(){return t.prototype.renderSite.apply(i,arguments)};this.getSite=function(){return t.prototype.getSite.apply(i,arguments)};this.urlCount=n.length;this.sites=new e(n);this.imagePath="images/";this.images=r}t.prototype.getSite=function(){return this.sites.get(Math.floor(Math.random()*this.urlCount))};t.prototype.getDuration=function(e,t){e==null&&(e=0);t==null&&(t=10);return Math.floor(Math.random()*t*1e3)+e*1e3};t.prototype.renderSite=function(e){var t,n;if(e){n=$("<div />").html(e.content).jrumble({x:Math.floor(Math.random()*3),y:Math.floor(Math.random()*3),rotation:0,speed:Math.random()*10,opacity:!0,opacityMin:Math.random()});t=$("<a class='site' href='"+e.url+"'/>").css({top:""+(100-Math.random()*200)+"%",left:""+(100-Math.random()*200)+"%",right:""+(100-Math.random()*200)+"%"}).html(n);$("body").css("background-image","url("+this.imagePath+this.images[Math.floor(Math.random()*this.images.length)]+")").append(t);n.trigger("startRumble");t.animate({right:""+Math.random()*50+"%"},this.getDuration(.001,1,"linear"));setTimeout(function(){return t.trigger("stopRumble").remove()},this.getDuration(.5,2));return setTimeout(this.doIt,this.getDuration(0,1))}return this.doIt()};t.prototype.doIt=function(){var e=this.getSite();return e.response.done(this.renderSite)};t.prototype.init=function(){var e=this,t=this.getDuration(3,5);setTimeout(function(){$("#prefill").addClass("site");return $("#nav").jrumble({x:0,y:0,rotation:.05,speed:10,opacity:!0}).trigger("startRumble")},t);return setTimeout(function(){$("body").addClass("loading");return $("#prefill").animate({right:""+(30+Math.random()*50)+"%"},e.getDuration(3,5),"swing",function(){e.doIt();return setTimeout(function(){return $("#prefill").remove()},e.getDuration(.5,2))})},t+this.getDuration(3,5))};return t}()}).call(this);