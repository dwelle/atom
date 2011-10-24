#import "AtomApp.h"
#import "AtomController.h"
#import "JSCocoa.h"

@implementation AtomApp

@synthesize controllers;

- (AtomController *)createController {
  AtomController *controller = [[AtomController alloc] initWithWindowNibName:@"AtomWindow"];
  [controllers addObject:controller];
  return controller;
}

- (void)removeController:(AtomController *)controller {
  [controllers removeObject:controller];
}

// Overridden
- (void)sendEvent:(NSEvent *)event {
  switch ([event type]) {
    case NSKeyDown:
    {
      BOOL handeled = NO;
      id controller = [[self keyWindow] windowController];
      
      // The keyWindow could be a Cocoa Dialog or something, ignore them.
      if ([controller isKindOfClass:[AtomController class]]) {
        handeled = [controller handleKeyEvent:event];
      }
      
      if (!handeled) {
        [super sendEvent:event];
      }
      
    }
      break;
    default:
      [super sendEvent:event];
      break;
  }
}

// AppDelegate
- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
  NSDictionary *defaults = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], @"WebKitDeveloperExtras", nil];
  [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  AtomController *controller = [self createController];
  [controller window];
}

@end
