{ lib, ... }:

{
  # Generates a Home Manager activation entry to symlink a file/binary
  # ONLY on non-NixOS distributions (e.g., Ubuntu).
  mkNonNixosSymlink = { sourcePath, targetPath }:
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -f /etc/NIXOS ]; then
        export PATH="/usr/bin:/bin:$PATH"
        
        SOURCE="${sourcePath}"
        TARGET="${targetPath}"
        TARGET_DIR="$(dirname "$TARGET")"

        if [ -f "$SOURCE" ] || [ -d "$SOURCE" ]; then
          if [ -w "$TARGET_DIR" ]; then
            mkdir -p "$TARGET_DIR"
            ln -sf "$SOURCE" "$TARGET"
          elif [ -x /usr/bin/sudo ]; then
            /usr/bin/sudo /bin/mkdir -p "$TARGET_DIR"
            /usr/bin/sudo /bin/ln -sf "$SOURCE" "$TARGET"
          fi
        fi
      fi
    '';
}
