# Vendored host headers

Copies of Schwung's `src/host/` headers, so this module builds on its own.

**Never add a field to `plugin_api_v1.h`.**

A module's copy can only be OLDER than the host, never newer. Appending a
callback here does not create one — it makes this module read past the end of
the struct the host actually passed, and the guard every module writes
(`if (host->fn)`) then tests memory belonging to something else.

That is not hypothetical: a module appended `get_project_bpm` after
`get_beat_position`, which resolved to +120 — one past the host's last field —
found a non-NULL value belonging to the next member of a heap instance, passed
its own guard, and jumped into a `rw-p` page. SIGSEGV on the SPI callback takes
the audio process with it and **boot-loops the device**, because the slot is
restored every boot and crashes before the UI can be used to remove it.

The host reserves tail space so an over-read finds NULL and that guard does what
it was written to do. Keep these files in step with the host by COPYING them,
not by editing them.
