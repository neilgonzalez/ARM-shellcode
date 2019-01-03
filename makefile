make:
	as -o <name>.o <name>.s && ld -N -o <name> <name>.o
	objcopy -O binary <name> <name>.bin
	hexdump -v -e '"\\""x" 1/1 "%02x" ""' main.bin && echo
