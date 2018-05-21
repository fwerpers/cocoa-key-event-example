#import <Cocoa/Cocoa.h>
#include<iostream>
#include<map>

class NoteController {
 private:
	std::map<int, bool> key_states = {
		{11, false}, // b
		{45, false}, // n
		{46, false} // m
	};
 public:
	void set_key(int keycode) {
		if (!key_states[keycode]) {
			key_states[keycode] = true;
			std::cout << "Key down!" << std::endl;
		}
	}
	void release_key(int keycode) {
		if (key_states[keycode]) {
			key_states[keycode] = false;
			std::cout << "Key up!" << std::endl;
		}
	}
};

@interface MyWindow : NSWindow
@property NoteController controller;
@end

@implementation MyWindow
- (void)keyDown:(NSEvent *)theEvent {
	UInt16 key_code = [theEvent keyCode];
	_controller.set_key(key_code);
	//std::cout << "Key down!" << key_code << std::endl;
}
- (void)keyUp:(NSEvent *)theEvent {
	UInt16 key_code = [theEvent keyCode];
	_controller.release_key(key_code);
	//std::cout << "Key up!"  << key_code << std::endl;
}
@end

@interface MyApplication : NSApplication
@end

int main ()
{
    [NSAutoreleasePool new];
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    id menubar = [[NSMenu new] autorelease];
    id appMenuItem = [[NSMenuItem new] autorelease];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];
    id appMenu = [[NSMenu new] autorelease];
    id appName = [[NSProcessInfo processInfo] processName];
    id quitTitle = [@"Quit " stringByAppendingString:appName];
    id quitMenuItem = [[[NSMenuItem alloc] initWithTitle:quitTitle
        action:@selector(terminate:) keyEquivalent:@"q"] autorelease];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];
    id window = [[[MyWindow alloc] initWithContentRect:NSMakeRect(0, 0, 200, 200)
        styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:NO]
            autorelease];
    [window cascadeTopLeftFromPoint:NSMakePoint(20,20)];
    [window setTitle:appName];
    [window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
    return 0;
}
