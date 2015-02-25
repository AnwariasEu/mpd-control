const Lang = imports.lang;
const Applet = imports.ui.applet;
const GLib = imports.gi.GLib;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;
const Gettext = imports.gettext.domain('cinnamon-applets');
const _ = Gettext.gettext;

function MyApplet(orientation) {
    this._init(orientation);
}

MyApplet.prototype = {
  __proto__: Applet.IconApplet.prototype,

  _init: function(orientation) {
    Applet.IconApplet.prototype._init.call(this, orientation);  

    try {
      this.set_applet_icon_name("mpd-pause");
      this.set_applet_tooltip(_("Pause/Start Playback"));
    }
    catch (e) {
      global.logError(e);
    }
  },

  on_applet_clicked: function(event) {
    GLib.spawn_command_line_sync('mpc toggle');
    this._toggle_icon();
  },

  _toggle_icon: function(){
      let [result, stdout, stderr] = GLib.spawn_command_line_sync('mpc status');
    if ( stdout.toString().match(/playing/g)) {
      this.set_applet_icon_name("mpd-play");
    } else {
      this.set_applet_icon_name("mpd-pause");
    }
  },

};

function main(metadata, orientation) {
  let myApplet = new MyApplet(orientation);
  return myApplet;
}
