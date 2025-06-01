#!/bin/bash

#GITHUB => 'https://github.com/CYBER-MRINAL'
#TELEGRAM => 'https://t.me/CYBERMRINAL'
#INSTAGRAM => 'https://instagram.com/CYBERMRINAL'
#FOR any type of issue or any new suggestion give me a dm on TELEGRAM or INSTAGRAM
#also YOU can use GITHUB
#Feel free to send new suggetion and security tools to include in this script
#All time i am trying new tools for include in it and create linux more secure and easy
#to use. So feel free to send me.

# Configuration
LOGFILE="/var/log/linux_defender.log"
SCAN_DIRS=("/home" "/etc" "/usr/bin" "/usr/sbin")
BACKUP_DIR="/var/backups/linux_defender"
CHECKSUM_FILE="/var/backups/checksums.sha256"
SCRIPT_PATH="$(realpath "$0")"
HISTORY_FILE="/var/.command_history"

# Load history from file if it exists
if [[ -f "$HISTORY_FILE" ]]; then
    history -r "$HISTORY_FILE"
fi

# Function to check if the script is run as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "\033[1;31m"  # Red color
        echo "   <)}==={RUN-THIS-SCRIPT-WITH-SUDO-OR-IN-ROOT-USER}==={(>"
        echo -e "\033[0m"  # Reset color
        exit 1
    fi
}

# Function to save history to file
save_history() {
    history -a "$HISTORY_FILE"
}

# Function to log messages
log_message() {
    local level="$1"
    local message="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$level] $message" >> $LOGFILE
}

# Function to send alerts
send_alert() {
    local message="$1"
    echo "Sending alert: $message"  # Debugging line
}

# Function to display colorful welcome message
display_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<===============================>>"
    echo "                         <<-WELCOME-TO-LINUX-DEFENDER->>"
    echo "                       <<===============================>>"
    echo "                             <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for ufw
display_ufw_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<============================>>"
    echo "                         <<-WELCOME-TO-UFW-MANAGER->>"
    echo "                       <<============================>>"
    echo "                            <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for supdate
display_supdate_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<============================>>"
    echo "                         <<-WELCOME-TO-SYS-UPDATER->>"
    echo "                       <<============================>>"
    echo "                            <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for scan
display_scan_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<=============================>>"
    echo "                         <<-WELCOME-TO-SCAN-MANAGER->>"
    echo "                       <<=============================>>"
    echo "                            <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for traffic
display_traffic_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<========================================>>"
    echo "                         <<-WELCOME-TO-NETWORK-PIRVACY-MANAGER->>"
    echo "                       <<========================================>>"
    echo "                                   <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for backup
display_backup_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<===============================>>"
    echo "                         <<-WELCOME-TO-BACKUP-MANAGER->>"
    echo "                       <<===============================>>"
    echo "                             <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for css
display_css_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<===================================>>"
    echo "                         <<-WELCOME-TO-SYS-STATUS-MANAGER->>"
    echo "                       <<===================================>>"
    echo "                                <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for css
display_cfi_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<=============================================>>"
    echo "                         <<-WELCOME-TO-CHECK-FILE-INTEGRITY-MANAGER->>"
    echo "                       <<=============================================>>"
    echo "                                     <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for css
display_report_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                   <<==================>>---=====---<<=================>>"
    echo "                     <<-WELCOME-TO-LINUX-DEFENDER-REOPORT-GENERATOR->>"
    echo "                   <<==================>>---=====---<<=================>>"
    echo "                                    <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display colorful welcome message for system monitor
display_monitor_welcome() {
    echo -e "\033[1;32m"  # Green color
    echo "                       <<====================================>>"
    echo "                         <<-WELCOME-TO-SYS-MONITOR-SECTION->>"
    echo "                       <<====================================>>"
    echo "                               <<-=-CYBER-MRINAL-=->>       "
    echo -e "\033[0m"  # Reset color
}

# Function to display a futuristic banner
display_banner1() {
    echo -e "\033[1;36m"  # Cyan color
    echo "                                             ███████╗███████╗ ██████╗██╗   ██╗██████╗ ███████╗    ███████╗██╗   ██╗███████╗"
    echo "                                             ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██╔════╝    ██╔════╝╚██╗ ██╔╝██╔════╝"
    echo "                                             ███████╗█████╗  ██║     ██║   ██║██████╔╝█████╗█████╗███████╗ ╚████╔╝ ███████╗"
    echo "                                             ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██╔══╝╚════╝╚════██║  ╚██╔╝  ╚════██║"
    echo "                                             ███████║███████╗╚██████╗╚██████╔╝██║  ██║███████╗    ███████║   ██║   ███████║"
    echo "                                             ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚══════╝   ╚═╝   ╚══════╝"
    echo "                                             <<==========================>>{CYBER-MRINAL}<<==============================>>"
    echo "                                                     <<==========={https://github.com/CYBER-MRINAL}===========>>"
    echo "                                                             <<=======================================>> "
    echo -e "\033[0m"  # Reset color
}

#for banner command banner 
display_banner(){
    echo -e "\033[1;36m"
    echo "                         <<))===================================================================================================================((>>"
    echo "                                ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗     ██████╗ ███████╗███████╗███████╗███╗   ██╗██████╗ ███████╗██████╗ "
    echo "                                ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝     ██╔══██╗██╔════╝██╔════╝██╔════╝████╗  ██║██╔══██╗██╔════╝██╔══██╗"
    echo "                                ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝█████╗██║  ██║█████╗  █████╗  █████╗  ██╔██╗ ██║██║  ██║█████╗  ██████╔╝"
    echo "                                ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗╚════╝██║  ██║██╔══╝  ██╔══╝  ██╔══╝  ██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗"
    echo "                                ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗     ██████╔╝███████╗██║     ███████╗██║ ╚████║██████╔╝███████╗██║  ██║"
    echo "                                ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝     ╚═════╝ ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝"
    echo "                         <<))================================================={CYBER-MRINAL}====================================================((>>"
    echo -e "\033[0m"
}

# Main function to run user commands
run_user_commands() {
    local current_section="HOME"

    while true; do
        # Read input with readline support
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " user_command

        # Exit the loop if the user types 'exit'
        if [[ "$user_command" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$user_command" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$user_command"

        # Execute the command if it's valid
        case "$user_command" in
            "exit")
                break
                ;;
            "help")
                echo -e "\033[1;32m" "\nAvailable Commands (AC):"
                echo "  ls        - List avaliable security tools in this framework"
                echo "  cd        - To enter New Choosen Section (cd ufw)"
                echo "  cd ..     - To get back from one section to HOME menu"
                echo "  clear     - Clear the terminal"
                echo "  exit      - Exit the command interface"
                echo "  banner    - To show the banner"
                echo "  welcome   - To show the welcome banner"
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "cd ufw")
                current_section="UFW"
                manage_firewall
                current_section="HOME"
                ;;
            "cd supdate")
                current_section="SUPDATE"
                update_system
                current_section="HOME"
                ;;
            "cd scan")
                current_section="SCAN"
                scan_for_danger
                current_section="HOME"
                ;;
            "cd backup")
                current_section="BACKUP"
                backup_files
                current_section="HOME"
                ;;
            "cd cfi")
                current_section="CFI"
                check_integrity
                current_section="HOME"
                ;;
            "cd report")
                current_section="REPORT"
                generate_report
                current_section="HOME"
                ;;
            "cd css")
                current_section="SYS-STATUS"
                check_sys_status
                current_section="HOME"
                ;;
            "cd tupdate")
                current_section="TUPDATE"
                update_from_github
                current_section="HOME"
                ;;
            "cd anon")
                current_section="ANON"
                traffic_anony
                current_section="HOME"
                ;;
            "cd monitor")
                current_section="MONITOR"
                monitor_files
                current_section="HOME"
                ;;
            "banner")
                display_banner
                ;;
            "welcome")
                display_welcome
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "cd ..")
                current_section="HOME"  # Only set to HOME when "back" is entered
                ;;
            "ls")
                echo -e "\033[1;32m" "\nAvailable Security Tools (AST):"
                echo "  cfi      - Check file integrity manager"
                echo "  css      - Check system status"
                echo "  ufw      - Manage UFW firewall rules"
                echo "  scan     - Scan and find malware and rootkit"
                echo "  anon     - Anonymous network traffic manager"
                echo "  backup   - Backup critical files"
                echo "  report   - Generate a report of your whole system"
                echo "  supdate  - Update the distribution "
                echo "  tupdate  - Update to the latest veriosn of this tool."
                echo "  monitor  - Monitor files and changes while testing something on system."
                echo -e "\033[0m"
                ;;
            *)
                eval "$user_command"
                ;;
        esac

        # Save history to file
        save_history
    done
}

# Function to manage UFW firewall rules
manage_firewall() {
    local current_section="UFW"

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        # Read input with readline support
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "enable")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ON}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw enable
                log_message "INFO" "UFW enabled."
                send_alert "UFW has been enabled."
                ;;
            "disable")
                echo -e "\033[1;32m"
                echo "<<==={UFW-OFF}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw disable
                log_message "INFO" "UFW disabled."
                send_alert "UFW has been disabled."
                ;;
            "assh")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-SSH}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow ssh
                log_message "INFO" "SSH allowed through UFW."
                send_alert "SSH has been allowed through UFW."
                ;;
            "dssh")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-SSH}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw deny ssh
                log_message "INFO" "SSH denied through UFW."
                send_alert "SSH has been denied through UFW."
                ;;
            "ahttp")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-HTTP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow http
                log_message "INFO" "HTTP allowed through UFW."
                send_alert "HTTP has been allowed through UFW."
                ;;
            "dhttp")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-HTTP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw deny http
                log_message "INFO" "HTTP denied through UFW."
                send_alert "HTTP has been denied through UFW."
                ;;
            "ahttps")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-HTTPS}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow https
                log_message "INFO" "HTTPS allowed through UFW."
                send_alert "HTTPS has been allowed through UFW."
                ;;
            "dhttps")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-HTTPS}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw deny https
                log_message "INFO" "HTTPS denied through UFW."
                send_alert "HTTPS has been denied through UFW."
                ;;
            "statv")
                echo -e "\033[1;32m"
                echo "<<==={UFW-STATUS-VERBOSE}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw status verbose
                ;;
            "statn")
                echo -e "\033[1;32m"
                echo "<<==={UFW-STATUS-NUMBERED}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw status numbered
                ;;
            "urest")
                echo -e "\033[1;32m"
                echo "<<==={UFW-RESETER}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw reset
                ;;
            "uload")
                echo -e "\033[1;32m"
                echo "<<==={UFW-STATUS-NUMBERED}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw reload
                ;;
            "aftp")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-FTP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow ftp
                log_message "INFO" "FTP allowed through UFW."
                send_alert "FTP has been allowed through UFW."
                ;;
            "dftp")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-FTP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow ftp
                log_message "INFO" "FTP denied through UFW."
                send_alert "FTP has been denied through UFW."
                ;;
            "deny-all")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-ALL}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw default deny
                log_message "INFO" "All traffic denied by default."
                send_alert "All traffic is now denied by default."
                ;;
            "den-in")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-INCOMING}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw default deny incoming
                log_message "INFO" "All incoming traffic denied by default."
                send_alert "All incoming traffic is now denied by default."
                ;;
            "alw-out")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-OUTGOING}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw default allow outgoing
                log_message "INFO" "Outgoing traffic allowed by default."
                send_alert "Outgoing traffic is now allowed by default."
                ;;
            "den-out")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-OUTGOING}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw deny outgoing
                log_message "INFO" "Outgoing traffic denied."
                send_alert "Outgoing traffic has been denied."
                ;;
            "aping")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-PING}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow proto icmp
                log_message "INFO" "Ping (ICMP) allowed through UFW."
                send_alert "Ping has been allowed through UFW."
                ;;
            "dping")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-PING}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw deny proto icmp
                log_message "INFO" "Ping (ICMP) denied through UFW."
                send_alert "Ping has been denied through UFW."
                ;;
            "adns")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-DNS}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow dns
                log_message "INFO" "DNS allowed through UFW."
                send_alert "DNS has been allowed through UFW."
                ;;
            "ddns")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-DNS}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow dns
                log_message "INFO" "DNS Denied through UFW."
                send_alert "DNS has been Denied through UFW."
                ;;
            "asmtp")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-SMTP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow smtp
                log_message "INFO" "SMTP allowed through UFW."
                send_alert "SMTP has been allowed through UFW."
                ;;
            "dsmtp")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-SMTP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw deny smtp
                log_message "INFO" "SMTP denied through UFW."
                send_alert "SMTP has been denied through UFW."
                ;;
            "apop3")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-POP3}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow pop3
                log_message "INFO" "POP3 allowed through UFW."
                send_alert "POP3 has been allowed through UFW."
                ;;
            "dpop3")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-POP3}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw Deny pop3
                log_message "INFO" "POP3 denied through UFW."
                send_alert "POP3 has been denied through UFW."
                ;;
            "aimap")
                echo -e "\033[1;32m"
                echo "<<==={UFW-ALLOW-IMAP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw allow imap
                log_message "INFO" "IMAP allowed through UFW."
                send_alert "IMAP has been allowed through UFW."
                ;;
            "dimap")
                echo -e "\033[1;32m"
                echo "<<==={UFW-DENY-IMAP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw deny imap
                log_message "INFO" "IMAP denied through UFW."
                send_alert "IMAP has been denied through UFW."
                ;;
            "clear")
                clear
                ;;
            "banner")
                display_ufw_welcome
                ;;
            "help")
                echo -e "\033[1;32m" "\nUFW Help (UFWH):"
                echo "  ls     - To List preset UFW rules for use"
                echo "  cd ..  - To get back to the HOME Menu."
                echo "  clear  - Clear the terminal."
                echo "  banner - Show the banner of UFW"
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "ls")
                echo -e "\033[1;32m" "Available Options (AO):"
                echo "  enable    - Enable UFW"
                echo "  disable   - Disable UFW"
                echo "  assh      - Allow SSH"
                echo "  dssh      - Deny SSH"
                echo "  ahttp     - Allow HTTP"
                echo "  dhttp     - Deny HTTP"
                echo "  ahttps    - Allow HTTPS"
                echo "  dhttps    - Deny HTTPS"
                echo "  aftp      - Allow FTP "
                echo "  dftp      - Deny FTP "
                echo "  aping     - Allow Ping (ICMP)"
                echo "  dping     - Deny Ping (ICMP)"
                echo "  adns      - Allow DNS "
                echo "  ddns      - Deny DNS "
                echo "  asmtp     - Allow SMTP"
                echo "  dsmtp     - Deny SMTP"
                echo "  apop3     - Allow POP3"
                echo "  dpop3     - Deny P0P3"
                echo "  aimap     - Allow IMAP"
                echo "  dimap     - Deny IAMP"
                echo "  deny-all  - Deny all Internet Traffic"
                echo "  den-in    - Deny all incoming Traffic"
                echo "  alw-out   - Allow Outgoing Traffic"
                echo "  den-out   - Deny Outgoing Traffic"
                echo "  urest     - Reset the UFW and take it to normal"
                echo "  uload     - Reload the UFW "
                echo "  statv     - Show UFW status in verbose."
                echo "  statn     - Show UFW status in numbered."
                echo -e "\033[0m"  # Reset color
                ;;
            "cd ..")
                return
                ;;
            *)
                echo "-->> Invalid Command. Please use 'show' to see the commands."
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

#Update Distro funciton
update_system() {
    local current_section="SUPDATE"

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "pdeb")
                if sudo parrot-upgrade -y; then
                    log_message "INFO" "PARROT OS updated successfully."
                    send_alert "PARROT OS updated successfully."
                else
                    log_message "ERROR" "PARROT OS system update failed."
                    send_alert "PARROT OS system update failed. Check the log for details."
                fi
                ;;
            "kdeb")
                if sudo apt full-upgrade -y; then
                    log_message "INFO" "KALI linux updated successfully."
                    send_alert "KALI linux updated successfully."
                else
                    log_message "ERROR" "KALI linux system update failed."
                    send_alert "KALI linux system update failed. Check the log for details."
                fi
                ;;
            "deb")
                sudo apt-get update -y
                sudo apt-get upgrade -y
                log_message "INFO" "Ububtu/Debian Update Successfully."
                send_alert "Your disro is updated successfully."
                ;;
            "arch")
                if sudo pacman -Syyu --noconfirm; then
                    log_message "INFO" "Arch system updated successfully."
                    send_alert "Arch system updated successfully."
                else
                    log_message "ERROR" "Arch system update failed."
                    send_alert "Arch system update failed. Check the log for details."
                fi
                ;;
            "rhat")
                if sudo dnf upgrade --refresh -y; then
                    log_message "INFO" "Red Hat/CentOS/Fedora system updated successfully."
                    send_alert "Red Hat/CentOS/Fedora system updated successfully."
                else
                    log_message "ERROR" "Red Hat/CentOS/Fedora system update failed."
                    send_alert "Red Hat/CentOS/Fedora system update failed. Check the log for details."
                fi
                ;;
            "help")
                echo -e "\033[1;32m" "\nSUPDATE Help (SUPH):"
                echo "   ls     - List all preset commands"
                echo "   cd ..  - To get back the HOME Menu."
                echo "   clear  - Clear the terminal."
                echo "   banner - Show  the banner"
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "banner")
                display_supdate_welcome
                ;;
            "ls")
                echo -e "\033[1;32m" "\nCoose Your Distro Type (CYDT):"
                echo ">  deb   - Update Ubuntu/Debain system"
                echo ">  pdeb  - Update parrot os"
                echo ">  kdeb  - Update Kali linux"
                echo ">  arch  - Update Arch"
                echo ">  rhat  - Update Red Hat/CentOS/Fedora"
                echo -e "\033[0m"  # Reset color
                ;;
            "cd ..")
                return  # Exit the update management section and go back to the main menu
                ;;
            *)
                echo "-->> Invalid Command. Please use show to see the commands."
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

update_from_github() {
    local repo="CYBER-MRINAL/LINUX-DEFENDER"  # Exact GitHub repository (case-sensitive)
    local current_version="v1.0"               # Your current version (update as needed)
    local latest_version
    local zip_file
    local temp_dir
    local url
    local http_status

    # Check for required commands
    for cmd in curl unzip grep sort; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "Error: $cmd is not installed. Please install it and try again."
            return 1
        fi
    done

    # Check if the repository exists by checking HTTP status code
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "https://api.github.com/repos/${repo}")
    if [[ "$http_status" != "200" ]]; then
        echo "Error: Repository $repo does not exist or is inaccessible. HTTP status code: $http_status"
        return 1
    fi

    # Fetch the latest release version from GitHub API
    latest_version=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" | grep -oP '"tag_name": "\K(.*)(?=")')
    if [[ -z "$latest_version" ]]; then
        echo "Error: Failed to fetch the latest version from the repository."
        return 1
    fi

    echo "Current version: $current_version"
    echo "Latest version: $latest_version"

    # Compare versions; if current >= latest, no update needed
    if [[ $(echo -e "${current_version}\n${latest_version}" | sort -V | head -n1) == "$latest_version" ]]; then
        echo "You are already running the latest version: $current_version"
        return 0
    fi

    # Prepare download info
    temp_dir=$(mktemp -d) || { echo "Failed to create temp directory."; return 1; }
    zip_file="${repo##*/}-${latest_version}.zip"
    url="https://github.com/${repo}/releases/download/${latest_version}/${zip_file}"

    echo "Downloading $zip_file from $url..."

    # Download release zip
    if ! curl -L -o "$temp_dir/$zip_file" "$url"; then
        echo "Error: Failed to download $zip_file. Check the URL or tag."
        rm -rf "$temp_dir"
        return 1
    fi

    echo "Download completed."

    # Extract ZIP file quietly
    if ! unzip -q "$temp_dir/$zip_file" -d "$temp_dir"; then
        echo "Error: Failed to extract $zip_file."
        rm -rf "$temp_dir"
        return 1
    fi

    echo "Extraction completed."

    # TODO: Replace this with actual move/copy logic for your project files
    # e.g., mv "$temp_dir/extracted_folder/*" /your/project/directory/
    # Adjust this path according to your repo structure after extraction

    echo "Cleaning up temporary files..."
    rm -rf "$temp_dir"

    echo "Update completed successfully."
    return 0
}

# Function to scan for malware using multiple tools
scan_for_danger() {
    local current_section="SCAN"
    local scan_pid=0

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "clam")
                log_message "INFO" "Scanning for malware with ClamAV..."
                for dir in "${SCAN_DIRS[@]}"; do
                    clamscan -r "$dir" | tee -a $LOGFILE &
                    scan_pid=$!  # Store the PID of the background process
                    wait "$scan_pid"  # Wait for the scan to complete
                    if [[ $? -ne 0 ]]; then
                        log_message "WARNING" "Malware detected in $dir with ClamAV!"
                        send_alert "Malware detected in $dir with ClamAV! Check the log for details."
                    fi
                done
                send_alert "ClamAV scan completed."
                scan_pid=0  # Reset PID after completion
                ;;
            "rkit")
                log_message "INFO" "Checking for rootkits using rkhunter..."
                sudo rkhunter --check | tee -a $LOGFILE &
                scan_pid=$!  # Store the PID of the background process
                wait "$scan_pid"  # Wait for the scan to complete
                if [[ $? -eq 0 ]]; then
                    send_alert "Rootkit check completed. No issues found."
                    log_message "INFO" "Rootkit check completed. No issues found."
                else
                    send_alert "Rootkit check completed. Issues found! Check the log for details."
                    log_message "WARNING" "Rootkit check completed. Issues found!"
                fi
                scan_pid=0  # Reset PID after completion
                ;;
            "help")
                echo -e "\033[1;32m" "\nSCAN Help (SCANH):"
                echo "  ls     - Show the available security tools for scan"
                echo "  cd ..  - Return to the HOME Menu."
                echo "  clear  - Clear the terminal."
                echo "  banner - Show the banner."
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "ls")
                echo -e "\033[1;32m" "\nSCAN Options (SCANO):"
                echo "  clam - Scan for malware using ClamAV."
                echo "  rkit - Check for rootkits using rkhunter."
                echo "                                           "
                echo ">> WARNING: THIS CAN TAKE TIME SO KEEP PATIENCE & PRESSING CTRL+C STOP THE WHOLE SCRIPT SO, DON'T PRESS CTRL+C NOW"
                echo -e "\033[0m"  # Reset color
                ;;
            "banner")
                display_scan_welcome
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "cd ..")
                return  # Exit the scan management section and go back to the main menu
                ;;
            *)
                echo "-->> Invalid Command. Please use show to see the commands."
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

# Function to go through Tor circuit
traffic_anony() {
    local current_section="ANON"

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "dstart")
                echo -e "\033[1;32m"
                echo "<<==={TOR-MODE-ON}===>>"
                echo -e "\033[0m"  # Reset color
                sudo anonsurf start
                log_message "INFO" "All network traffic is routing through Tor."
                send_alert "Tor network traffic is running now."
                ;;
            "dchnid")
                echo -e "\033[1;32m"
                echo "<<==={TOR-CHANGED-IP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo anonsurf changeid
                log_message "INFO" "TOR changed Ip address for debain"
                send_alert "Your IP address changed now."
                ;;
            "dstop")
                echo -e "\033[1;32m"
                echo "<<==={TOR-MODE-OFF}===>>"
                echo -e "\033[0m"  # Reset color
                sudo anonsurf stop
                log_message "INFO" "All network traffic is routing Normally."
                send_alert "Tor network traffic is stop."
                ;;
            "kstart")
                echo -e "\033[1;32m"
                echo "<<==={TOR-MODE-ON}===>>"
                echo -e "\033[0m"  # Reset color
                sudo anonsurf start
                log_message "INFO" "All network traffic is routing through Tor (KALI)."
                send_alert "Tor network traffic is running now."
                ;;
            "kchnid")
                echo -e "\033[1;32m"
                echo "<<==={TOR-CHANGED-IP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo anonsurf change
                log_message "INFO" "TOR changed Ip address for Kali"
                send_alert "Your IP address changed now."
                ;;
            "kstop")
                echo -e "\033[1;32m"
                echo "<<==={TOR-MODE-OFF}===>>"
                echo -e "\033[0m"  # Reset color
                sudo anonsurf stop
                log_message "INFO" "All network traffic is routing kali."
                send_alert "Tor network traffic is stop."
                ;;
            "astart")
                echo -e "\033[1;32m"
                echo "<<==={TOR-MODE-ON}===>>"
                echo -e "\033[0m"  # Reset color
                sudo torctl start 
                log_message "INFO" "All network traffic is routing through Tor."
                send_alert "Tor network is started now."
                ;;
            "achnid")
                echo -e "\033[1;32m"
                echo "<<==={TOR-CHANGED-IP}===>>"
                echo -e "\033[0m"  # Reset color
                sudo torctl chngid
                log_message "INFO" "TOR changed IP address for ARCH."
                send_alert "Your IP address changed now."
                ;;
            "achnmc")
                echo -e "\033[1;32m"
                echo "<<==={TOR-CHANGED-MAC}===>>"
                echo -e "\033[0m"  # Reset color
                sudo torctl chngmac
                log_message "INFO" "TOR changed MAC address for ARCH."
                send_alert "Your MAC address changed now."
                ;;
            "astop")
                echo -e "\033[1;32m"
                echo "<<==={TOR-MODE-OFF}===>>"
                echo -e "\033[0m"  # Reset color
                sudo torctl stop 
                log_message "INFO" "All network traffic is routing Normally."
                send_alert "Tor network is stop"
                ;;
            "help")
                echo -e "\033[1;32m" "\nANONY Help (ANONYH):"
                echo "  ls     - Show the available security options to start Tor."
                echo "  cd ..  - Return to the main menu."
                echo "  clear  - Clear the terminal."
                echo "  banner - Show the banner."
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "ls")
                echo -e "\033[1;32m" "\nANONY Options (ANONYO):"
                echo "--> WARNING: FOR KALI LINUX PLEASE INSTALL KALI-ANONSURF FORM GITHUB."
                echo "--> INFO: My research is still going to resolv other distro tor tool."
                echo "                                                " 
                echo "> DEBIAN-TOR:"
                echo "   dstart  - For parrot os, to start Tor tunnel."
                echo "   dchnid  - For parrot os, to change Tor IP Address."
                echo "   dstop   - For parrot os, to stop Tor tunnel."
                echo "                                                      "
                echo "> KALI-TOR:"
                echo "   kstart  - For kali, to start Tor tunnel."
                echo "   kchnid  - For kali, to change Tor IP Address."
                echo "   kstop   - For kali, to stop Tor tunnel."
                echo "                                          "
                echo "> ARCH-TOR:"
                echo "   astart  - For Arch, to start Tor tunnel."
                echo "   achnid  - For Arch, to change IP address of TOR."
                echo "   achnmc  - For Arch, to change MAC address of TOR."
                echo "   astop   - For Arch, to stop TOR tunnel."
                echo -e "\033[0m"  # Reset color
                ;;
            "banner")
                display_traffic_welcome
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "cd ..")
                return  # Exit the scan management section and go back to the main menu
                ;;
            *)
                echo "-->> Invalid Command. Please use show to see the commands."
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

# Function to backup critical files
backup_files() {
    local current_section="BACKUP"
    local BACKUP_DIR="$HOME/normal_backup"  # Default backup directory
    local SCAN_DIRS=()

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "custsf")
                read -p "> Specify backup storage path: " BACKUP_DIR
                echo "-> You have chosen to back up to: $BACKUP_DIR"
                echo "==> Specify folders to backup (type 'done' when finished):"
                while true; do
                    read -p "=> Folder: " dir
                    if [[ "$dir" == "done" ]]; then
                        break
                    fi
                    if [[ -d "$dir" ]]; then
                        SCAN_DIRS+=("$dir")
                    else
                        echo "-> Directory does not exist. Please enter a valid folder."
                    fi
                done
                ;;
            "help")
                echo -e "\033[1;32m" "\nBACKUP Help (BACKH):"
                echo "   ls     - Show the available backup options"
                echo "   cd ..  - to return to the main menu."
                echo "   clear  - Clear the terminal"
                echo "   banner - Show the banner."
                echo -e "\033[0m"  # Reset color
                ;;
            "ls")
                echo -e "\033[1;32m" "\nBACKUP Option (BACKO):"
                echo "  custsf    - Custom Storage and Custom Folder"
                echo "                                              "
                echo "==>> IF any other backup idea you have then send me on (https://t.me/CYBERMRINAL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "banner")
                display_backup_welcome
                ;;
            "cd ..")
                return  # Exit the backup management section and go back to the main menu
                ;;
            *)
                echo "-->> Invalid Command. Please use help to see the commands."
                ;;
        esac

        # Check if the user has specified folders to back up
        if [[ ${#SCAN_DIRS[@]} -gt 0 ]]; then
            # Create the backup directory if it doesn't exist
            mkdir -p "$BACKUP_DIR"

            # Perform the backup
            log_message "INFO" "> Backing up files to $BACKUP_DIR..."
            for dir in "${SCAN_DIRS[@]}"; do
                cp -r "$dir" "$BACKUP_DIR" >> $LOGFILE 2>&1
                if [[ $? -eq 0 ]]; then
                    log_message "INFO" "Successfully backed up $dir to $BACKUP_DIR."
                    echo "=> Successfully backed up $dir to $BACKUP_DIR."
                else
                    log_message "ERROR" "Failed to back up $dir. Check the log for details."
                    echo "-> Failed to back up $dir. Check the log for details."
                fi
            done
            send_alert "==>> Backup completed."
            echo "=> Backup files are kept at: $BACKUP_DIR"
        fi

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

# Function to check system status
check_sys_status() {
    local current_section="CSS"

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "ufws")
                echo -e "\033[1;32m"
                echo "<<==={UFW-STATUS}===>:"
                echo -e "\033[0m"  # Reset color
                sudo ufw status verbose
                log_message "INFO" "UFW status checked."
                send_alert "UFW STATUS IS SHOWN."
                ;;
            "disks")
                echo -e "\033[1;32m"
                echo "<<==={DISK-USAGE-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                df -h
                log_message "INFO" "Disk status checked"
                send_alert "DISK USAGE STATUS IS SHOWN."
                ;;
            "rams")
                echo -e "\033[1;32m"
                echo "<<==={MEMORY-USAGE-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                free -h
                log_message "INFO" "Memory/Ram usage status checked."
                send_alert "MEMORY/RAM STATUS IS SHOWN."
                ;;
            "rsers")
                echo -e "\033[1;32m"
                echo "<<==={RUNNING-SERVICES-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                systemctl list-units --type=service --state=running
                log_message "INFO" "Running services status checked."
                send_alert "RUNNING SERVICE STATUS SHOWN."
                ;;
            "fails")
                echo -e "\033[1;32m"
                echo "<<==={FAIL2BAN-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                sudo fail2ban-client status
                log_message "INFO" "Fail2ban status checked."
                send_alert "FAIL2BAN STATUS SHOWN."
                ;;
            "cpu")
                echo -e "\033[1;32m"
                echo "<<==={CPU-INFO}===>>"
                echo -e "\033[0m"  # Reset color
                lscpu
                log_message "INFO" "CPU information ."
                send_alert "CPU INFO SHOWN."
                ;;
            "short")
                echo -e "\033[1;32m"
                echo "<<==={SHROT-INFO}===>>"
                echo -e "\033[0m"  # Reset color
                inxi
                log_message "INFO" "INXI information ."
                send_alert "SHORT INFO SHOWN."
                ;;
            "pci")
                echo  -e "\033[1;32m"
                echo "<<==={PCI-INFO}===>>"
                echo -e "\033[0m"
                lspci
                log_message "INFO" "PCI information ."
                send_alert "PCI INFO SHOWN."
                ;; 
            "all")
                echo -e "\033[1;32m"
                echo "<<=========================>>"
                echo "  <<--ALL-SYSTEM-STATUS-->>"
                echo "<<=========================>>"
                echo -e "\033[0m"  # Reset color
                echo ""
                echo -e "\033[1;32m"
                echo "<<==={UFW-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                sudo ufw status verbose
                echo ""
                echo -e "\033[1;32m"
                echo "<<==={DISK-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                df -h
                echo ""
                echo -e "\033[1;32m"
                echo "<<==={RAM-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                free -h
                echo ""
                echo -e "\033[1;32m"
                echo "<<==={CPU-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                lscpu
                inxi
                echo ""
                echo -e "\033[1;32m"
                echo "<<==={UPTIME-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                uptime
                echo ""
                echo  -e "\033[1;32m"
                echo "<<==={PCI-INFO}===>>"
                echo -e "\033[0m"
                lspci
                echo ""
                echo -e "\033[1;32m"
                echo "<<==={SERVICES-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                systemctl list-units --type=service --state=running
                echo ""
                echo -e "\033[1;32m"
                echo "<<==={FAIL2BAN-STATUS}===>>"
                echo -e "\033[0m"  # Reset color
                sudo fail2ban-client status
                echo ""
                log_message "INFO" "ALL status is checked in once"
                send_alert "ALL SYS-STATUS IS SHOWN"
                ;;
            "help")
                echo -e "\033[1;32m" "\nCSS Help (CSSH):"
                echo "  ls     - Show the available security options to start Tor."
                echo "  cd ..  - Return to the main menu."
                echo "  clear  - Clear the terminal."
                echo "  banner - Show the banner."
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "ls")
                echo -e "\033[1;32m" "\nCSS Option (CSSO):"
                echo "  all   - Show all of above in once."
                echo "  cpu   - Show the cpu information."
                echo "  pci   - Show all hardware information in detail."
                echo "  ufws  - Show the ufw status in verbose."
                echo "  rams  - Show the ram/memory usage status."
                echo "  rsers - Show the running services."
                echo "  fails - Show the fail2ban status."
                echo "  disks - Show the disk spaces in humab readable format."
                echo "  short - Show CPU, SPEED, KERNEL, UPTIME, MEMORY, STORAGE, etc. lot information. (RECOMMANDED)"
                echo -e "\033[0m"  # Reset color
                ;;
            "banner")
                display_css_welcome
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "cd ..")
                return  # Exit the scan management section and go back to the main menu
                ;;
            *)
                echo "-->> Invalid Command. Please use show to see the commands."
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

# Function to generate a detailed report
generate_report() {
    local current_section="LDRG"
    local report_file1="/tmp/linux_defender_new_report.txt"
    local report_file2="/tmp/linux_defender_log_report.txt"
    local log_file="/var/log/linux_defender.log"
    local format_option

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "generate")
                {
                    echo -e "\033[1;32m"
                    echo "<<==========================================>>"
                    echo "<<====={LINUX-DEFENDER-REPORT-GENERATOR}====>>"
                    echo "<<==========================================>>"
                    echo "Date: $(date)"
                    echo -e "\033[0m"
                    echo ""

                    echo -e "\033[1;32m"
                    echo "<<==={OS-DETAILS-START}===>>"
                    echo -e "\033[0m"
                    cat /etc/os-release
                    uname -r
                    uname -m
                    echo -e "\033[1;32m"
                    echo "<<==={OS-DETAILS-DONE}===>>"
                    echo -e "\033[0m"
                    echo ""

                    echo -e "\033[1;32m"
                    echo "<<============>>---====---<<=============>>"
                    echo "         <<--ALL-SYSTEM-STATUS-->>"
                    echo "<<============>>---====---<<=============>>"
                    echo -e "\033[0m"  # Reset color
                    echo ""
                    echo -e "\033[1;32m"
                    echo "<<==={UFW-STATUS}===>>"
                    echo -e "\033[0m"  # Reset color
                    sudo ufw status verbose
                    echo ""
                    echo -e "\033[1;32m"
                    echo "<<==={DISK-STATUS}===>>"
                    echo -e "\033[0m"  # Reset color
                    df -h
                    echo ""
                    echo -e "\033[1;32m"
                    echo "<<==={RAM-STATUS}===>>"
                    echo -e "\033[0m"  # Reset color
                    free -h
                    echo ""
                    echo -e "\033[1;32m"
                    echo "<<==={CPU-STATUS}===>>"
                    echo -e "\033[0m"  # Reset color
                    lscpu
                    inxi
                    echo ""
                    echo -e "\033[1;32m"
                    echo "<<==={UPTIME-STATUS}===>>"
                    echo -e "\033[0m"  # Reset color
                    uptime
                    echo ""
                    echo  -e "\033[1;32m"
                    echo "<<==={PCI-INFO}===>>"
                    echo -e "\033[0m"
                    lspci
                    echo ""
                    echo -e "\033[1;32m"
                    echo "<<==={SERVICES-STATUS}===>>"
                    echo -e "\033[0m"  # Reset color
                    systemctl list-units --type=service --state=running
                    echo ""

                    echo -e "\033[1;32m"
                    echo "<<==={FAIL2BAN-CHECK-START}===>>"
                    echo -e "\033[0m"
                    echo ""
                    sudo fail2ban-client status
                    echo -e "\033[1;32m"
                    echo "<<==={FAIL2BAN-CHECK-DONE}===>>"
                    echo -e "\033[0m"
                    echo ""                
                } > "$report_file1"

                log_message "INFO" ">> REPORT GENERATED $report_file1."
                echo -e "\033[1;32m"
                echo "> Report is here -> /tmp/linux_defender_new_report.txt"
                echo -e "\033[0m"
                send_alert "Linux Defender report generated. Check the attached report."
                ;;
            "oldlog")
                if [[ -f $log_file ]]; then
                    echo ">> GENERATING REPORT FROM -> $log_file"
                    echo -e "\033[1;32m"
                    echo "> Report is here -> /tmp/linux_defender_log_report.txt"
                    echo -e "\033[0m"
                    cat "$log_file" > "$report_file2"
                    log_message "INFO" "Report generated from old log file at $report_file2."
                    send_alert "Report generated from old log file. Check the attached report."
                    echo ""
                else
                    echo "Log file not found: $log_file"
                fi
                ;;
            "ls")
                echo -e "\033[1;32m" "\nLlinux Defender Reprot Generator Option (LDRGO):"
                echo "  generate - Generate a new report. (HARDWARE)"
                echo "  oldlog   - Generate a report from the old log file."
                echo -e "\033[0m"  # Reset color
                ;;
            "help")
                echo -e "\033[1;32m" "\nLinux Defender Reprot Generator Help (LDRGH):"
                echo "  ls     - Show the available security options to start Tor."
                echo "  cd ..  - Return to the main menu."
                echo "  clear  - Clear the terminal."
                echo "  banner - Show the banner."
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "cd ..")
                return  # Exit the report generation section and go back to the main menu
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "banner")
                display_report_welcome
                ;;
            *)
                echo "-->> Invalid Command. Please use help to see the commands."
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

# Function to check file integrity for security reason
check_integrity() {
    local current_section="CFI"

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "cfiv")
                echo -e "\033[1;32m"
                echo "                                  <<============>>---====---<<=============>>"
                echo "                                           <<--CFI-IN-VERBOSE-WAY-->>"
                echo "                                  <<============>>---====---<<=============>>"
                echo -e "\033[0m"  # Reset color
                log_message "INFO" "Checking file integrity in Verbose way."

                # Create a temporary file to capture output
                TEMP_OUTPUT=$(mktemp)

                # Open xterm and run the commands inside it
                xterm -hold -e bash -c "
                    echo 'INFO: Checking file integrity...'

                    if [[ ! -f $CHECKSUM_FILE ]]; then
                        echo 'INFO: Creating checksum file...'
                        find \"\${SCAN_DIRS[@]}\" -type f -exec sha256sum {} \\; > \"$CHECKSUM_FILE\"
                        send_alert 'Checksum file created.'
                    else
                        echo 'INFO: Verifying checksums...'
                        # Capture the output of sha256sum and save to temporary file
                        sha256sum -c \"$CHECKSUM_FILE\" 2>&1 | tee \"$TEMP_OUTPUT\"
                        if [[ \${PIPESTATUS[0]} -eq 0 ]]; then
                            send_alert 'File integrity check passed. All files are intact.'
                            echo 'INFO: File integrity check passed. All files are intact.'
                        else
                            send_alert 'File integrity check failed! Some files have been modified.'
                            echo 'WARNING: File integrity check failed! Some files have been modified.'
                        fi
                    fi
                " &

                # Wait for xterm to finish
                wait

                # Display mismatched files in the main terminal
                if [[ -f "$TEMP_OUTPUT" ]]; then
                    echo "Mismatched files:"
                    grep 'FAILED' "$TEMP_OUTPUT" | while IFS= read -r line; do
                        # Extract the filename from the line
                        filename=$(echo "$line" | awk '{print $1}')
                        echo -e "\e[31m$filename\e[0m"  # Display the filename in red
                    done
                fi

                # Clean up the temporary file
                rm "$TEMP_OUTPUT"
                ;;
            "cfin")
                    echo -e "\033[1;32m"
                    echo "                                      <<============>>---====---<<=============>>"
                    echo "                                               <<--CFI-IN-NORMAL-WAY-->>"
                    echo "                                      <<============>>---====---<<=============>>"
                    echo -e "\033[0m"  # Reset color
                    log_message "INFO" "Checking file integrity normal way."
                    if [[ ! -f $CHECKSUM_FILE ]]; then
                        log_message "INFO" "Creating checksum file..."
                        find "${SCAN_DIRS[@]}" -type f -exec sha256sum {} \; > $CHECKSUM_FILE
                        send_alert "Checksum file created."
                    else
                        log_message "INFO" "Verifying checksums..."
                        if sha256sum -c $CHECKSUM_FILE; then
                            send_alert "File integrity check passed. All files are intact."
                            log_message "INFO" "File integrity check passed. All files are intact."
                        else
                            send_alert "File integrity check failed! Some files have been modified."
                            log_message "WARNING" "File integrity check failed! Some files have been modified."
                        fi
                    fi
                    ;;
            "ls")
                echo -e "\033[1;32m" "\nCheck File Integrity Option (CFIO):"
                echo "  cfin   - Check File Integrity in normal way. (WITHOUT_COLOR)"
                echo "  cfiv   - Check File Integrity in verbose way. (WITH_COLOR)"
                echo -e "\033[0m"  # Reset color
                ;;
            "help")
                echo -e "\033[1;32m" "\nCheck File Integrity Help (CFIH):"
                echo "  ls     - Show the available security options to start Tor."
                echo "  cd ..  - Return to the main menu."
                echo "  clear  - Clear the terminal."
                echo "  banner - Show the banner."
                echo ""
                echo -e "\033[1;31m"  # Red color
                echo ">> By pressing CTRL+C the whole script stops (BE CAREFULL)"
                echo -e "\033[0m"  # Reset color
                ;;
            "cd ..")
                return  # Exit the report generation section and go back to the main menu
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "banner")
                display_cfi_welcome
                ;;
            *)
                echo "-->> Invalid Command. Please use help to see the commands."
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

monitor_files() {
    local current_section="MONITOR"
    local MONITOR_DIRS=()
    local MONITOR_TOOL=""

    # Load history from file if it exists
    if [[ -f "$HISTORY_FILE" ]]; then
        history -r "$HISTORY_FILE"
    fi

    while true; do
        read -e -p " {LINUX-DEFENDER}-{${current_section}}-->> " option

        # Exit the loop if the user types 'exit'
        if [[ "$option" == "exit" ]]; then
            break
        fi

        # If the input is empty, continue to the next iteration
        if [[ -z "$option" ]]; then
            continue
        fi

        # Add the command to history
        history -s "$option"

        case $option in
            "iwait")
                echo -e "\033[1;3m"
                echo "<(:)===(IWAIT-MONITORING-STARTING)===(:)>"
                echo -e "\033[0m"
                MONITOR_TOOL="inotifywait"
                echo -e "\033[1;32m"
                echo "==> SPECIFY FOLDERS TO MONITOR (Type 'done' when finished):"
                echo -e "\033[0m"  # Reset color
                while true; do
                    read -p "=> Folder: " dir
                    if [[ "$dir" == "done" ]]; then
                        break
                    fi
                    if [[ -d "$dir" ]]; then
                        MONITOR_DIRS+=("$dir")
                    else
                        echo "-> Directory does not exist. Please enter a valid folder."
                    fi
                done

                if [[ ${#MONITOR_DIRS[@]} -gt 0 ]]; then
                    echo "=> Monitoring directories: ${MONITOR_DIRS[*]} using inotifywait"
                    if [[ -n "$DISPLAY" ]]; then
                        xterm -fa 'Monospace' -hold -e "bash -c 'inotifywait -m -r ${MONITOR_DIRS[*]}; exec bash'" &
                    else
                        echo "-> Error: DISPLAY environment variable is not set. Cannot open xterm."
                    fi
                else
                    echo "-> No directories specified. Please specify directories."
                fi
                ;;
            "iwatch")
                echo -e "\033[1;31m"
                echo "<(:)===(IWATCH-MONITORING-STARTING)===(:)>"
                echo -e "\033[0m"
                MONITOR_TOOL="inotifywatch"
                echo -e "\033[1;32m"
                echo "==> SPECIFY FOLDERS FOR MONITORING (Type 'done' when finished):"
                echo -e "\033[0m"  # Reset color
                while true; do
                    read -p "=> Folder: " dir
                    if [[ "$dir" == "done" ]]; then
                        break
                    fi
                    if [[ -d "$dir" ]]; then
                        MONITOR_DIRS+=("$dir")
                    else
                        echo "-> Directory does not exist. Please enter a valid folder."
                    fi
                done

                if [[ ${#MONITOR_DIRS[@]} -gt 0 ]]; then
                    echo "=> Monitoring directories: ${MONITOR_DIRS[*]} using inotifywatch"
                    if [[ -n "$DISPLAY" ]]; then
                        xterm -fa 'Monospace' -hold -e "bash -c 'inotifywatch -r -t 10 ${MONITOR_DIRS[*]}; exec bash'" &
                    else
                        echo "-> Error: DISPLAY environment variable is not set. Cannot open xterm."
                    fi
                else
                    echo "-> No directories specified. Please specify directories."
                fi
                ;;
            "help")
                echo -e "\033[1;32m" "\nMONITOR Help (MONH):"
                echo "   ls     - List available tools"
                echo "   cd ..  - to return to the main menu."
                echo "   clear  - Clear the terminal"
                echo "   banner - Show the banner of MONITOR."
                echo -e "\033[0m"  # Reset color
                ;;
            "ls")
                echo -e "\033[1;32m" "\nMONITOR Options (MON0):"
                echo "   iwait - Start monitoring with inotifywait"
                echo "   iwatch - Start monitoring with inotifywatch"
                echo -e "\033[0m"  # Reset color
                ;;
            "clear")
                clear  # Clear the terminal
                ;;
            "cd ..")
                return  # Exit the monitoring section and go back to the main menu
                ;;
            "banner")
                display_monitor_welcome
                ;;
            *)
                echo -e "\033[1;32m"
                echo "-->> Invalid Command. Please use help to see the commands."
                echo -e "\033[0m"  # Reset color
                ;;
        esac

        # Save history to file
        history -a "$HISTORY_FILE"
    done
}

# Main function
main() {
    check_root
    display_banner1
    run_user_commands
}

# Run the main function
main "$@"
