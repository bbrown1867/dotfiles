# dotfiles
My scripts and dotfiles.

## tmux

Session management outside `tmux`.

    tmux             # new unnamed session
    tmux new -s name # new named session
    tmux a           # attach to session
    tmux a -t myname # attach to named session
    tmux ls          # list sessions

Once inside `tmux`, the following shortcuts are used with prefix `<C-b>`.

    d           # detach (close tmux)
    :bind-key ? # list all shortcuts
    :new        # create new session
    s           # list sessions
    $           # name session

_Windows:_

    c           # create window
    w           # list windows
    n           # next window
    p           # previous window
    ,           # name window
    &           # kill window

_Panes:_

    %           # vertical split
    "           # horizontal split
    x           # kill pane

_Copy mode:_

    [           # enter copy mode (.tmux.conf: vim bindings)
    <Cr>        # exit copy mode
    <Space>     # begin select
    <Cr>        # end select (.tmux.conf: copy to clipboard)
    ]           # paste

## Arch Linux

### Install
0. Create a bootable Arch Linux USB stick.
    * Download ISO: <https://www.archlinux.org/download/>
    * Write to USB stick: `dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync`
    * Plug USB stick into machine and boot from it.
1. Check network connection.
    * Ethernet should work by default.
    * For Wi-Fi: `wifi-menu`
    * Verify connection: `ip addr`, `ping 8.8.8.8`
2. Sync package database.
    * `pacman -Syyy`
3. Format the hard drive.
    * Check disk names to locate the hard drive: `lsblk`
    * Run `fdisk /dev/sdx` to start configuration
        * `g`: Create GPT disk label
        * `n`, `t`: Create a 500 MB partition of type "EFI System" at the start of the disk
        * `n`, `t`: Create another partition of type "Linux filesystem" to fill the rest of the disk
        * `w`: Save configuration.
    * Format partitions.
        * `mkfs.fat -F32  /dev/sdx1`
        * `mkfs.ext4 /dev/sdx2`
4. Mount and setup Arch Linux base.
    * `mount /dev/sdx2 /mnt`
    * `mkdir /mnt/etc/`
    * `genfstab -U -p /mnt >> /mnt/etc/fstab`
    * `pacstrap -i /mnt base`
    * `arch-chroot /mnt`
5. Install and setup important packages.
    * `pacman -S linux-lts linux-lts-headers vim base-devel networkmanager netctl dialog`
    * `systemctl enable NetworkManger`
    * `mkinitcpio -p linux-lts`
6. Configure locale and timezone.
    * `vim /etc/locale.gen`: Uncomment line with `en_US.UTF-8`
    * `locale-gen`
    * `ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime`
    * `hwclock --systohc --utc`
    * Verify: `date`
7. Configure hostname.
    * `echo hostname > /etc/hostname`
    * `vim /etc/hosts`: Replace content with the following 3 lines
        * `127.0.0.1	localhost`
        * `::1		    localhost`
        * `127.0.1.1    hostname`
8. Setup root password and user.
    * `passwd`: Enter root password
    * `useradd -m -g users -G wheel ben`
    * `passwd`: Enter user password
    * `EDITOR=vim visudo`: Uncomment the `%wheel ALL=(ALL) ALL` line
9. Install bootloader.
    * `pacman -S grub efibootmgr`
    * `mkdir /boot/EFI`
    * `mount /dev/sdx1 /boot/EFI`
    * `grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck`
    * `grub-mkconfig -o /boot/grub/grub.cfg`
10. Make swapfile.
    * `fallocate -l 2G /swapfile`
    * `chmod 600 /swapfile`
    * `mkswap /swapfile`
    * `echo '/swapfile none swap sw 0 0' >> /etc/fstab`
11. Install firmware.
    * `pacman -S intel-ucode`.
12. Reboot into the new installation.
    * `exit` out of the new Arch installation back into the USB stick
    * Umount: `umount -a`
    * Reboot: `shutdown now`
    * Remove USB stick
    * Power on

### Config
* Font size may be really small on a high-quality display, so increase with the following command.
    * `setfont /usr/share/kbd/consolefonts/iso01-12x22.psfu.gz`
* KDE installation:
    * Minimal packages needed: `pacman -S xorg plasma konsole dolphin`
    * Enable on startup: `systemctl enable sddm.service`
    * For full set of default KDE applications: `pacman -S kde-applications`

### Other
* Check installed packages: `pacman -Q`
* Check installed services: `systemctl list-unit-files`
* Leave KDE (back to console): `CTRL + ALT + F2`
