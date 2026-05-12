# Cyber Security Guidelines

## Research & Learning

### Common Cyber Security Threats in a Remote Work Environment
- **Phishing attacks**: deceptive emails or messages impersonating trusted sources
- **Man-in-the-middle attacks**: intercepting communication on unsecured networks
- **Weak or reused passwords**: single point of failure across multiple accounts
- **Malware and ransomware**: malicious software delivered via downloads or links
- **Social engineering**: manipulating people into revealing sensitive information
- **ARP Poisoning**: attacker on the same network redirects traffic by sending fake ARP responses
- **Evil Twin Attack**: fake WiFi hotspot mimicking a legitimate network to intercept traffic
- **Unsecured home networks**: routers with default credentials or outdated firmware

### Best Practices for Keeping Devices and Accounts Secure
- Use a **password manager** to generate and store unique, strong passwords
- Prefer **passkeys** over passwords where services support them
- Enable 2FA on every account that supports it and prefer **TOTP** over SMS/email 2FA
- Use **email aliases** to avoid exposing real email addresses
- Use **SSH/GPG keys** instead of passwords wherever supported
- Keep software and OS updated to patch security vulnerabilities
- Use a paid and trusted **VPN** on untrusted networks
- Avoid clicking links in unsolicited emails or messages
- Regularly audit connected apps and revoke unnecessary access

### Why Locking Your Computer Matters
Even at home, leaving a device unlocked creates risk. Physical access to an unlocked machine bypasses all authentication. In a remote work context, locking also protects against accidental exposure during video calls or screen shares.

### Handling Phishing Attempts and Suspicious Links
- Verify the sender's email domain carefully. Spoofed addresses often differ by one character
- Don't click links directly. Navigate to the site manually
- When in doubt, verify through a separate channel (e.g. contact the person directly)
- Report suspicious emails to the team immediately
- Focus Bear specifically warned about gift card scams impersonating leadership, so always verify unusual requests directly with Jeremy

### What Makes a Strong Password
A strong password typically has the following characteristics:
- Minimum 16 characters
- Mix of uppercase, lowercase, numbers, and symbols
- Unique per account and should never be reused
- Randomly generated rather than based on personal information
- Stored in a trusted and audited password manager, and never written down or stored in plaintext
- Where supported, replaced entirely with a **passkey**

### Why 2FA is Important
Passwords alone can be compromised through phishing, data breaches, or brute force. 2FA adds a second layer that an attacker cannot access even with the correct password. 

**TOTP-based 2FA** (e.g. via an authenticator app, or your password manager) is strongly preferred over SMS or email 2FA, which are vulnerable to SIM-swapping and interception attacks. 2FA should be enabled on every account that supports it, prioritising email, banking, and work accounts.

**Hardware Security Keys** (e.g. YubiKey) provide the strongest form of 2FA where supported, as they're resistant to phishing unlike TOTP.

---

## Reflection

### Current Security Measures and Areas for Improvement
I've maintained a privacy-first digital hygiene practice for several years:

- **Password Manager:** Using Bitwarden (self-hosted via Vaultwarden) for around 3 years, having previously used 1Password for 2 years. All passwords are unique and randomly generated.
- **Passkeys:** Preferred over passwords wherever services support them.
- **2FA:** Enabled on virtually every account that supports it, exclusively using TOTP. SMS and email 2FA are avoided due to their vulnerability to interception and SIM-swapping.
- **Email Aliases:** Real email addresses are rarely shared. SimpleLogin and AnonAddy are used to generate aliases, significantly reducing phishing surface.
- **SSH/GPG Keys:** Preferred over passwords wherever supported. Using 1Password SSH Agent on macOS and custom wrappers over the GNOME SSH Agent on Linux.
- **OAuth2:** Self-hosted Pocket ID for OAuth2 authentication where possible.
- **Device Locking:** Both MacBook and phone auto-lock after 2 minutes of inactivity. Soduto (a KDE Connect client for macOS) allows remote locking of either device from the other.
- **Audits**: I periodically audit third-party app permissions and revoke access to services I no longer actively use.

**One area I can improve** is keeping my devices and software more consistently up to date. I tend to delay updates longer than ideal, which can leave known vulnerabilities unpatched.

### Making Secure Behaviour a Habit
Security habits work best when built into the workflow rather than treated as extra steps. Using a password manager eliminates the temptation to reuse passwords. Auto-lock removes the need to remember to lock manually. Preferring passkeys and SSH keys over passwords removes the password vector entirely where possible. The goal is to make the secure option the path of least resistance.

### Steps to Ensure Passwords and Accounts Remain Secure
- Continue using Vaultwarden for all password storage
- Periodically review and rotate passwords for high-value accounts
- Audit connected OAuth apps and revoke unused access
- Stay updated on new phishing techniques and social engineering tactics
- Continue preferring passkeys and SSH/GPG keys over passwords where supported

### Response to a Suspected Security Breach
1. Immediately change the password for the affected account
2. Revoke all active sessions
3. Check for unauthorised access or changes
4. Notify the Focus Bear team promptly
5. Review other accounts that share any connection to the compromised one
6. Document what happened for future reference

---

## Tasks Completed

- [x] Work accounts have strong, unique passwords managed via Bitwarden (Vaultwarden)
- [x] Passkeys used wherever supported
- [x] TOTP-based 2FA enabled on all accounts that support it
- [x] MacBook and phone set to auto-lock after 2 minutes of inactivity
- [x] Email aliases in use via SimpleLogin and AnonAddy
- [x] SSH/GPG keys preferred over passwords wherever supported
- [x] Periodically audit third-party app permissions and revoke unused access

### New Cyber Security Habit at Focus Bear
I will set a monthly reminder to review and update all devices and software, including firmware on routers and self-hosted services, to ensure known vulnerabilities are patched promptly.