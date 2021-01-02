#include <stdio.h>
#include <stdlib.h>

#include <X11/Xlib.h>
#include <X11/extensions/Xrandr.h>

#define die_if_null(what) \
if (! (what)) \
  return EXIT_FAILURE

int
main(int argc, char * * argv)
{
  int screen, rr_event_base, rr_error_base, rr_mask = RROutputChangeNotifyMask;
  Display* display;
  Window rootwindow;
  XEvent event;

  display = XOpenDisplay(getenv("DISPLAY"));
  die_if_null(display);

  screen = DefaultScreen(display);

  rootwindow = RootWindow(display, screen);
  die_if_null(rootwindow);

  XSelectInput(display, rootwindow, StructureNotifyMask);
  XRRSelectInput(display, rootwindow, rr_mask);
  XRRQueryExtension (display, &rr_event_base, &rr_error_base);

  XNextEvent(display, &event);
  return EXIT_SUCCESS;
}