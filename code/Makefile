.PHONY: flash

flash:
ifeq ($(FILE),)
	@echo "Error: This target can only be called with the FILE parameter. Usage: make flash FILE=<file_path>"
else
	@if [ -f program.sh ]; then \
		./program.sh $(FILE); \
	else \
		echo "Error: program.sh not found, take one from the z_programmers directory and name it program.sh in the lessons directory"; \
	fi
endif

