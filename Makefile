TARGET = iphone:clang:5.1:4.0

include theos/makefiles/common.mk

TWEAK_NAME = ActiContact
ActiContact_FILES = HBACListener.m HBACViewController.m
ActiContact_FRAMEWORKS = UIKit CoreGraphics AddressBookUI
ActiContact_LDFLAGS = -lactivator

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	@mkdir -p $(THEOS_STAGING_DIR)/Library/Activator/Listeners/ws.hbang.acticontact
	@cp Info.plist $(THEOS_STAGING_DIR)/Library/Activator/Listeners/ws.hbang.acticontact/Info.plist
