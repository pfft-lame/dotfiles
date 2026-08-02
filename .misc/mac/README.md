# I have bad memory :(

## add kanata service file to `/Library/LaunchDaemons/` since it needs root access

---

## also add org.pqrs.kanata.driverkit.plist to `/Library/LaunchDaemons/`

```bash
sudo chown root:wheel /Library/LaunchDaemons/org.pqrs.kanata.driverkit.plist
sudo chmod 644 /Library/LaunchDaemons/org.pqrs.kanata.driverkit.plist
```
