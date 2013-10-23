THEOS_DEVICE_IP = 192.168.1.105
export ARCHS = armv7
export TARGET = iphone:6.1:5.0

include theos/makefiles/common.mk

TWEAK_NAME = NoWeiBoGoodSleep
NoWeiBoGoodSleep_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
