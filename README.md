# Instalação Arch

# formatar disco
fdisk /dev/disk

# g - create a new empty GPT partition table
# n - add a new partition user +512M to set size
# w - write table to disk and exit
# EFI + Root example:
Device       Start       End   Sectors   Size Type
/dev/sda1     2048   1050623   1048576   512M EFI System
/dev/sda2  1050624 468875263 467824640 223.1G Linux filesystem


# efi
mkfs.fat -F 32 /dev/nvme0n1p1


# root
sudo mkfs.btrfs -f -L arch /dev/sdc1

# subvolumes
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/var

compress-force=zstd,noatime

mount -o subvol=root,compress-force=zstd,noatime /dev/sdc1 /mnt
mkdir /mnt/home
mount -o subvol=home,compress-force=zstd,noatime /dev/mapper/enc /mnt/home
mkdir /mnt/var
mount -o subvol=var,compress-force=zstd,noatime /dev/mapper/enc /mnt/var
swap

mkdir /mnt/nix
mount -o subvol=nix,compress=zstd,noatime /dev/mapper/enc /mnt/nix

# wifi
device list
iwctl --passphrase passphrase station name connect SSID


mount /dev/root_partition /mnt
mount --mkdir /dev/efi_system_partition /mnt/boot
# pacstrap /mnt base linux linux-firmware vim nano
pacstrap -K /mnt base linux linux-firmware sudo vim networkmanager git base-devel zsh
genfstab -U /mnt >> /mnt/etc/fstab

<!-- UUID=65B9-AB78      				/boot     	vfat      	rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro	0 2 -->
bootctl install

<!-- grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg -->

arch-chroot /mnt

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# users
useradd -m -G wheel -s /usr/bin/zsh andre
passwd

sudo vim /etc/sudoers


