const St = imports.gi.St;
const Lang = imports.lang;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;
const Main = imports.ui.main;
const GLib = imports.gi.GLib;
const Util = imports.misc.util;
const Mainloop = imports.mainloop;
const Applet = imports.ui.applet;
const Gettext = imports.gettext.domain('cinnamon-applets');
const _ = Gettext.gettext;

function MyApplet(orientation) {
    this._init(orientation);
}

MyApplet.prototype = {
  __proto__: Applet.TextApplet.prototype,

  _init: function(orientation) {
    Applet.TextApplet.prototype._init.call(this, orientation);

    this.statusLabel = new St.Label({
      text: "--",
      style_class: "temperature-label"
    });

    try {
      this.menu = new Applet.AppletPopupMenu(this, orientation);
      this.title='Warning';
      this.content='Please do stuff';
      this._update_stuff();
    }
    catch (e) {
      global.logError(e);
    }
  },

  on_applet_clicked: function(event) {
    this.menu.toggle();
  },

  _update_stuff: function() {
      let ret = GLib.spawn_command_line_sync('mpc status');
      let currentsong = ret[1].toString();
      this.title = currentsong.split("\n",1)[0];
      let items = new Array();
      this.set_applet_label(this.title);
      this.menu.box.get_children().forEach(function(c) {
	c.destroy()
      });

      let section = new PopupMenu.PopupMenuSection("SongTitel");
        let command=this.command;
        let item = new PopupMenu.PopupMenuItem("");
	if (ret[3] == 0) {
	  item.addActor(new St.Label({
	    text:currentsong,
            style_class: "sm-label"
	  }));
	}else{
	  item.addActor(new St.Label({
	    text:this.content,
            style_class: "sm-label"
	  }));
	}
        item.connect('activate',function() {
            Util.spawn(command);
        });
        section.addMenuItem(item);
      this.menu.addMenuItem(section);

        //update every 0.5 seconds
      Mainloop.timeout_add(500, Lang.bind(this, this._update_stuff));
  },

}

function main(metadata, orientation) {
    let myApplet = new MyApplet(orientation);
    return myApplet;
}
