TARGETS := lib/libfancontrol sysmodule overlay

.PHONY: all clean $(TARGETS)

all: $(TARGETS)
	mkdir -p ./out/switch/.overlays
	cp ./overlay/NX-FanControl.ovl ./out/switch/.overlays/Nx-FanControl.ovl
	
	mkdir -p ./out/atmosphere/contents/00FF0000B378D640/flags
	cp ./sysmodule/sysmodule.nsp ./out/atmosphere/contents/00FF0000B378D640/exefs.nsp
	touch ./out/atmosphere/contents/00FF0000B378D640/flags/boot2.flag
	@echo "build complete."

lib/libfancontrol:
	$(MAKE) -C $@ -j$(nproc)

overlay:
	$(MAKE) -C $@ -j$(nproc)

sysmodule:
	$(MAKE) -C $@ -j$(nproc)

clean:
	@rm -rf ./out
	@rm -rf ./lib/libfancontrol/debug
	@rm -rf ./lib/libfancontrol/lib
	@rm -rf ./lib/libfancontrol/release
	@rm -rf ./sysmodule/build
	@rm -rf ./overlay/build
	@find ./sysmodule -type f \( -name '*.elf' -o -name '*.npdm' -o -name '*.nso' -o -name '*.nsp' \) -exec rm -f {} \;
	@find ./overlay -type f \( -name '*.elf' -o -name '*.nacp' -o -name '*.ovl' \) -exec rm -f {} \;