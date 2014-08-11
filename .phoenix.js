// Key bindings and settings
//
var mash = ['cmd', 'alt', 'ctrl'];
var mashMove = ['alt', 'cmd'];
var mashShift = ['shift', 'alt', 'ctrl'];
var mousePositions = {};
nudgePixels = 10,
padding = 4,
previousSizes = {};

/**
 * Window movements
 */

function moveWindow(win, callback) {
    var frame = win.screen().frameWithoutDockOrMenu();
    if (callback) {
        callback(frame);
    }
    win.setFrame(frame);
}

function moveFocusedWindowOn(key, modifiers, callback) {
    api.bind(key, modifiers, function() {
        moveWindow(Window.focusedWindow(), callback);
    });
}

function moveToScreen(win, screen) {
    if (!screen) {
        return;
    }

    var frame = win.frame();
    var oldScreenRect = win.screen().frameWithoutDockOrMenu();
    var newScreenRect = screen.frameWithoutDockOrMenu();

    var xRatio = newScreenRect.width / oldScreenRect.width;
    var yRatio = newScreenRect.height / oldScreenRect.height;

    win.setFrame({
        x: (Math.round(frame.x - oldScreenRect.x) * xRatio) + newScreenRect.x,
        y: (Math.round(frame.y - oldScreenRect.y) * yRatio) + newScreenRect.y,
        width: Math.round(frame.width * xRatio),
        height: Math.round(frame.height * yRatio)
    });
}

/*
 * Full screen
 */

// This method can be used to push a window to a certain position and size on
// the screen by using four floats instead of pixel sizes.  Examples:
//
//     // Window position: top-left; width: 25%, height: 50%
//     someWindow.toGrid( 0, 0, 0.25, 0.5 );
Window.prototype.toGrid = function(x, y, width, height) {
    var screen = this.screen().frameWithoutDockOrMenu(),
        newFrame = {
            x: Math.round(x * screen.width) + padding + screen.x,
            y: Math.round(y * screen.height) + padding + screen.y,
            width: Math.round(width * screen.width) - (2 * padding),
            height: Math.round(height * screen.height) - (2 * padding)
        };

    // When setting the `height` to 1, the padding isn't applied at the bottom
    // end of the frame.  (I guess it's a bug.)  Setting the frame to a height
    // less than `1` first is a workaround to counter that behaviour.
    if (height === 1) {
        this.setFrame(
            _({}).extend(newFrame, {
                height: screen.height - 50
            })
        );
    }

    this.setFrame(newFrame);
    this.focusWindow();

    return this;
};

Window.prototype.toFullScreen = function() {
    return this.toGrid(0, 0, 1, 1);
};

Window.prototype.toggleFullscreen = function() {
    if (previousSizes[this]) {
        this.setFrame(previousSizes[this]);
        delete previousSizes[this];
    } else {
        previousSizes[this] = this.frame();
        this.toFullScreen();
    }

    return this;
};

/*
 * Nudge window
 */

// #### Window#nudgeLeft()
//
// Move the currently focussed window left by [`nudgePixel`] pixels.
Window.prototype.nudgeLeft = function(factor) {
    var win = Window.focusedWindow(),
        frame = win.frame(),
        pixels = nudgePixels * (factor || 1);

    frame.x -= (frame.x >= pixels) ? pixels : 0;
    win.setFrame(frame);
};

// #### Window#nudgeRight()
//
// Move the currently focussed window right by [`nudgePixel`] pixels.
Window.prototype.nudgeRight = function(factor) {
    var win = Window.focusedWindow(),
        frame = win.frame(),
        //maxLeft = win.screen().frameIncludingDockAndMenu().width - frame.width,
        pixels = nudgePixels * (factor || 1);

    //frame.x += ( frame.x < maxLeft - pixels ) ? pixels : 0;
    frame.x += (frame.x <= pixels) ? pixels : 0;
    win.setFrame(frame);
};


// #### Window#nudgeUp()
//
// Move the currently focussed window left by [`nudgePixel`] pixels.
Window.prototype.nudgeUp = function(factor) {
    var win = Window.focusedWindow(),
        frame = win.frame(),
        pixels = nudgePixels * (factor || 1);

    frame.y -= (frame.y >= pixels) ? pixels : 0;
    win.setFrame(frame);
};

// #### Window#nudgeDown()
//
// Move the currently focussed window right by [`nudgePixel`] pixels.
Window.prototype.nudgeDown = function(factor) {
    var win = Window.focusedWindow(),
        frame = win.frame(),
        maxLeft = win.screen().frameIncludingDockAndMenu().height - frame.height,
        pixels = nudgePixels * (factor || 1);

    frame.y += (frame.y < maxLeft - pixels) ? pixels : 0;
    win.setFrame(frame);
};

/**
 * Mouse position
 */

function save_mouse_position_for_now() {
    if (Window.focusedWindow() === undefined) {
        return;
    }
    mousePositions[Window.focusedWindow().title()] = MousePosition.capture();
}

function restore_mouse_position_for_now() {
    if (Window.focusedWindow() === undefined) {
        return;
    }
    if (mousePositions[Window.focusedWindow().title()] !== undefined) {
        MousePosition.restore(mousePositions[Window.focusedWindow().title()]);
    }
}

// Switch app version 1
function switchApp(appName) {
    //switch app, and remember mouse position
    save_mouse_position_for_now()
    api.launch(appName);
    restore_mouse_position_for_now()
}

// Start/select apps
App.allWithTitle = function(title) {
    return _(this.runningApps()).filter(function(app) {
        if (app.title() === title) {
            return true;
        }
    });
};

App.centreAll = function() {
    var apps = this.runningApps();

    if (_.isEmpty(apps)) {
        api.alert("No apps!" + title);
        return;
    }

    var windows = _.chain(apps)
        .map(function(x) {
            return x.allWindows();
        })
        .flatten()
        .value();

    activeWindows = _(windows).reject(function(win) {
        return win.isWindowMinimized();
    });
    if (_.isEmpty(activeWindows)) {
        api.alert("All windows minimized for " + title);
        return;
    }

    activeWindows.forEach(function(win) {
        moveWindow(win, function(frame) {
            frame.width *= 0.75
            frame.height *= 0.75
            frame.x += frame.width * 0.125
            frame.y += frame.height * 0.125
        });
    });
}

App.fullAll = function() {
    var apps = this.runningApps();

    if (_.isEmpty(apps)) {
        return;
    }

    var windows = _.chain(apps)
        .map(function(x) {
            return x.allWindows();
        })
        .flatten()
        .value();

    activeWindows = _(windows).reject(function(win) {
        return win.isWindowMinimized();
    });
    if (_.isEmpty(activeWindows)) {
        return;
    }

    activeWindows.forEach(function(win) {
        moveWindow(win);
    });
}

App.focusOrStart = function(title) {
    var apps = App.allWithTitle(title);
    if (_.isEmpty(apps)) {
        api.alert("Starting " + title);
        api.launch(title);
        return;
    }

    var windows = _.chain(apps)
        .map(function(x) {
            return x.allWindows();
        })
        .flatten()
        .value();

    activeWindows = _(windows).reject(function(win) {
        return win.isWindowMinimized();
    });
    if (_.isEmpty(activeWindows)) {
        api.alert("All windows minimized for " + title);
        return;
    }

    activeWindows.forEach(function(win) {
        win.focusWindow();
    });
};

App.switchToOtherWindowsOf = function() {
    var title = Window.focusedWindow().app().title();
    var apps = App.allWithTitle(title);
    if (_.isEmpty(apps)) {
        return;
    }

    var windows = _.chain(apps)
        .map(function(x) {
            return x.allWindows();
        })
        .flatten()
        .value();

    activeWindows = _(windows).reject(function(win) {
        return win.isWindowMinimized() || win.title() == '';
    });
    if (_.isEmpty(activeWindows) || activeWindows.length == 1) {
        return;
    }
    api.alert("Found active windows " + activeWindows.length);

    activeWindows.forEach(function(win) {
        if (win.title() == Window.focusedWindow().title())
            return;
        else {
            win.focusWindow();
            return;
        }
    });
}

// General bindings
// Split Screen Actions
moveFocusedWindowOn('up', mash, function(frame) {
    frame.height /= 2
});
moveFocusedWindowOn('down', mash, function(frame) {
    frame.y += frame.height / 2
    frame.height /= 2
});
moveFocusedWindowOn('left', mash, function(frame) {
    frame.width /= 2
});
moveFocusedWindowOn('right', mash, function(frame) {
    frame.x += frame.width / 2
    frame.width /= 2
});

// Quarter Screen (Quadrant) Actions
moveFocusedWindowOn('up', mashShift, function(frame) {
    frame.x += frame.width / 2
    frame.width /= 2
    frame.height /= 2
});
moveFocusedWindowOn('down', mashShift, function(frame) {
    frame.y += frame.height / 2
    frame.width /= 2
    frame.height /= 2
});
moveFocusedWindowOn('left', mashShift, function(frame) {
    frame.width /= 2
    frame.height /= 2
});
moveFocusedWindowOn('right', mashShift, function(frame) {
    frame.x += frame.width / 2
    frame.y += frame.height / 2
    frame.width /= 2
    frame.height /= 2
});

// Move windows
//
api.bind('up', mashMove, function() {
    Window.focusedWindow().nudgeUp();
});

api.bind('right', mashMove, function() {
    Window.focusedWindow().nudgeRight();
});

api.bind('down', mashMove, function() {
    Window.focusedWindow().nudgeDown();
});

api.bind('left', mashMove, function() {
    Window.focusedWindow().nudgeLeft();
});

// Other Actions
moveFocusedWindowOn("f", mash)
moveFocusedWindowOn("c", mash, function(frame) {
    frame.width *= 0.75
    frame.height *= 0.75
    frame.x += frame.width * 0.125
    frame.y += frame.height * 0.125
});

api.bind('space', mash, function() {
    Window.focusedWindow().toggleFullscreen();
});

api.bind('right', ['ctrl', 'alt'], function() {
    var win = Window.focusedWindow();
    moveToScreen(win, win.screen().nextScreen());
});
api.bind('left', ['ctrl', 'alt'], function() {
    var win = Window.focusedWindow();
    moveToScreen(win, win.screen().previousScreen());
});

var cmdCtrl = ['ctrl', 'cmd'];
api.bind('t', cmdCtrl, function() {
    App.focusOrStart('iTerm');
});
api.bind('v', cmdCtrl, function() {
    App.focusOrStart('MacVim');
});
api.bind('c', cmdCtrl, function() {
    App.focusOrStart('Google Chrome');
});
api.bind('1', cmdCtrl, function() {
    App.focusOrStart('nsight');
});
api.bind('f', cmdCtrl, function() {
    App.focusOrStart('finder');
});

api.bind('=', mash, function() {
    App.centreAll();
});
api.bind('-', mash, function() {
    App.fullAll();
});
