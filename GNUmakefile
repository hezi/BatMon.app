#
# GNUmakefile - Generated by ProjectCenter
#
ifeq ($(GNUSTEP_MAKEFILES),)
 GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
  ifeq ($(GNUSTEP_MAKEFILES),)
    $(warning )
    $(warning Unable to obtain GNUSTEP_MAKEFILES setting from gnustep-config!)
    $(warning Perhaps gnustep-make is not properly installed,)
    $(warning so gnustep-config is not in your PATH.)
    $(warning )
    $(warning Your PATH is currently $(PATH))
    $(warning )
  endif
endif
ifeq ($(GNUSTEP_MAKEFILES),)
 $(error You need to set GNUSTEP_MAKEFILES before compiling!)
endif

include $(GNUSTEP_MAKEFILES)/common.make

#
# Application
#
VERSION = 0.8
PACKAGE_NAME = batmon
APP_NAME = batmon
batmon_APPLICATION_ICON = BatMon_Icon.png


#
# Resource files
#
batmon_RESOURCE_FILES = \
Resources/batmon.gorm \
Resources/small_battery.tif \
Resources/small_plug.tif \
Resources/BatMon_Icon.png \
Resources/battery-full.png \
Resources/battery-empty.png \
Resources/LICENSE \
Resources/README 


#
# Header files
#
batmon_HEADER_FILES = \
AppController.h \
BatteryModel.h

#
# Objective-C Class files
#
batmon_OBJC_FILES = \
AppController.m \
BatteryModel.m

#
# Other sources
#
batmon_OBJC_FILES += \
main.m 

#
# Makefiles
#
-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/aggregate.make
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble
