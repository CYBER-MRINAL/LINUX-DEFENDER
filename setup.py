#!/usr/bin/env python3

import os
import subprocess
import sys

arch_packages = [
    "tor", "torctl", "chkrootkit", "clamav", "audit", "iptables",
    "ufw", "inotify-tools", "rkhunter", "inxi", "xterm"
]
debian_packages = [
    "tor", "chkrootkit", "clamav", "auditd", "iptables",
    "ufw", "inotify-tools", "rkhunter", "inxi", "xterm"
]

def run_cmd(command):
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError:
        raise RuntimeError(f"Failed to run: {command}")

def get_distro():
    if os.path.exists('/etc/os-release'):
        with open('/etc/os-release') as f:
            data = f.read().lower()
            if 'arch' in data:
                return 'arch'
            elif 'kali' in data:
                return 'kali'
            elif 'parrot' in data:
                return 'parrot'
            elif 'debian' in data:
                return 'debian'
    return 'unknown'

def show_manual_instructions(distro):
    print("\n[!] Automated installation failed.")
    if distro == 'arch':
        print("[Manual Install - Arch Based Systems]")
        print("sudo pacman -S --noconfirm " + " ".join(arch_packages))
    elif distro in ['debian', 'kali', 'parrot']:
        print("[Manual Install - Debian Based Systems]")
        print("sudo apt install -y " + " ".join(debian_packages))
        if distro == 'kali':
            print("\nAlso run:")
            print("git clone https://github.com/Und3rf10w/kali-anonsurf.git")
            print("cd kali-anonsurf && sudo ./installer.sh")

def install_packages(distro):
    try:
        if distro == 'arch':
            run_cmd('sudo pacman -Syu --noconfirm')
            run_cmd('sudo pacman -S --noconfirm ' + " ".join(arch_packages))
        elif distro in ['kali', 'parrot', 'debian']:
            run_cmd('sudo apt update && sudo apt upgrade -y')
            run_cmd('sudo apt install -y ' + " ".join(debian_packages))
            if distro == 'kali':
                print("[INFO] Cloning and installing kali-anonsurf...")
                run_cmd('git clone https://github.com/Und3rf10w/kali-anonsurf.git')
                run_cmd('cd kali-anonsurf && sudo ./installer.sh')
        else:
            print("[ERROR] Unsupported distro.")
            sys.exit(1)
    except RuntimeError as e:
        print(f"[ERROR] {e}")
        show_manual_instructions(distro)
        sys.exit(1)

def main():
    distro = get_distro()
    print(f"[INFO] Detected Linux distribution: {distro}")
    install_packages(distro)
    print("[INFO] Installation complete. You can now run the Linux-Defender.sh script.")

if __name__ == '__main__':
    main()

