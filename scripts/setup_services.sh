#!/bin/bash

# Setup Docker and Virtualization Packages

echo "Installing required packages..."
doas pacman -S --needed docker docker-compose libvirt virt-manager bluez bluez-utils cups runit --noconfirm

echo "Adding user to required groups..."
# Add the current user to the docker and libvirt groups
doas usermod -aG docker "$USER"
doas usermod -aG libvirt "$USER"

if command -v sv >/dev/null 2>&1; then
    echo "Enabling and starting services with runit..."
    for service in docker libvirtd bluetoothd cupsd; do
        source=""
        for candidate in "/etc/runit/sv/$service" "/etc/sv/$service"; do
            if [ -d "$candidate" ]; then
                source="$candidate"
                break
            fi
        done

        target=""
        for candidate in /run/runit/service /var/service; do
            if [ -d "$candidate" ]; then
                target="$candidate/$service"
                break
            fi
        done

        if [ -n "$source" ] && [ -n "$target" ]; then
            doas ln -sfn "$source" "$target"
            doas sv start "$service"
        else
            echo "runit service definition for $service was not found; skipped."
        fi
    done
else
    echo "runit is unavailable; services were installed but not enabled or started."
fi

echo "Setup complete!"
echo "Log out and back in for the group changes to take effect."
