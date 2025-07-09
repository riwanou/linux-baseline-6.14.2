KDIR := invocation_directory()
LLVM := ""

build:
    echo nproc=$(nproc) LLVM={{LLVM}}
    make LLVM={{LLVM}} ARCH=x86 -j$(nproc)

install:
    make modules_install -j$(nproc)
    INSTALL_PATH={{KDIR}} make install
    TMPDIR=/tmp update-initramfs -c -k 6.14.2+ -b {{KDIR}}

kexec:
    kexec -l {{KDIR}}/vmlinuz-6.14.2+ --initrd={{KDIR}}/initrd.img-6.14.2+ --reuse-cmdline
    kexec -e
